!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'lm 6/27/2022 00:36:55'!
test01import

	CustomerImporter valueFrom: self validImportData into: session.

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'lm 6/27/2022 00:38:51'!
test02customerRecordMustBeginWithCOnly

	self should: [CustomerImporter valueFrom: self invalidImportCustomerData into: session.] raise: Error - MessageNotUnderstood withExceptionDo:[
		:anError | self assert: CustomerImporter invalidRecordType equals: anError messageText.
		self assert: 0 equals: (session selectAllOfType: Customer) size.
		].! !

!ImportTest methodsFor: 'tests' stamp: 'lm 6/27/2022 00:38:40'!
test03addressRecordMustBeginWithAOnly

	self should: [CustomerImporter valueFrom: self invalidImportAddressData into: session.] raise: Error - MessageNotUnderstood withExceptionDo: [
		:anError | self assert: CustomerImporter invalidRecordType equals: anError messageText.
		self assert: 0 equals: (session selectAllOfType: Address) size.
		].! !

!ImportTest methodsFor: 'tests' stamp: 'lm 6/23/2022 20:53:45'!
test04emptyDataShouldFail

	self should: [CustomerImporter valueFrom: self invalidImportEmptyData into: session.] raise: Error - MessageNotUnderstood withExceptionDo: [
		:anError | self assert: CustomerImporter emptyData equals: anError messageText.
		self assert: 0 equals: (session selectAllOfType: Address) size.
		self assert: 0 equals: (session selectAllOfType: Customer) size.
		].! !

!ImportTest methodsFor: 'tests' stamp: 'lm 6/27/2022 00:19:22'!
test05customerFieldsCannotBeLessThanFive

	self should: [CustomerImporter valueFrom: self invalidCustomerLessFieldsData into: session.] raise: Error - MessageNotUnderstood withExceptionDo: [
		:anError | self assert: CustomerImporter invalidFieldsQuantity equals: anError messageText.
		self assert: 0 equals: (session selectAllOfType: Customer) size.
		].! !

!ImportTest methodsFor: 'tests' stamp: 'lm 6/27/2022 00:19:48'!
test06addressFieldsCannotBeLessThanSix

	self should: [CustomerImporter valueFrom: self invalidAddressLessFieldsData into: session.] raise: Error - MessageNotUnderstood withExceptionDo: [
		:anError | self assert: CustomerImporter invalidFieldsQuantity equals: anError messageText.
		self assert: 0 equals: (session selectAllOfType: Address) size.
		].! !

!ImportTest methodsFor: 'tests' stamp: 'lm 6/27/2022 00:36:30'!
test07addressesMustBelongToCustomer

	self should: [CustomerImporter valueFrom: self invalidAddressesWithNoCustomerData into: session.] raise: Error - MessageNotUnderstood withExceptionDo: [
		:anError | self assert: CustomerImporter addressMustBelongToCustomer equals: anError messageText.
		self assert: 0 equals: (session selectAllOfType: Address) size.
		].! !

!ImportTest methodsFor: 'tests' stamp: 'lm 6/27/2022 00:20:11'!
test08customerFieldsCannotBeMoreThanFive

	self should: [CustomerImporter valueFrom: self invalidCustomerMoreFieldsData into: session.] raise: Error - MessageNotUnderstood withExceptionDo: [
		:anError | self assert: CustomerImporter invalidFieldsQuantity equals: anError messageText.
		self assert: 0 equals: (session selectAllOfType: Customer) size.
		].! !

!ImportTest methodsFor: 'tests' stamp: 'lm 6/27/2022 00:24:17'!
test09addressFieldsCannotBeMoreThanSix

	self should: [CustomerImporter valueFrom: self invalidAddressMoreFieldsData into: session.] raise: Error - MessageNotUnderstood withExceptionDo: [
		:anError | self assert: CustomerImporter invalidFieldsQuantity equals: anError messageText.
		self assert: 0 equals: (session selectAllOfType: Address) size.
		].! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:12:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:27:50'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:28:23'!
tearDown

	session commit.
	session close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'HAW 5/22/2022 18:14:22'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !


!ImportTest methodsFor: 'test data' stamp: 'lm 6/27/2022 00:16:22'!
invalidAddressLessFieldsData

	^ ReadStream on: 
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636'! !

!ImportTest methodsFor: 'test data' stamp: 'lm 6/27/2022 00:18:02'!
invalidAddressMoreFieldsData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAsA,Maipu,888,Florida,1122,Buenos Aires'! !

!ImportTest methodsFor: 'test data' stamp: 'lm 6/27/2022 00:36:30'!
invalidAddressesWithNoCustomerData
	^ ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'.! !

!ImportTest methodsFor: 'test data' stamp: 'lm 6/27/2022 00:16:47'!
invalidCustomerLessFieldsData

	^ ReadStream on: 'C,Pepe,Sanchez,D'! !

!ImportTest methodsFor: 'test data' stamp: 'lm 6/27/2022 00:17:44'!
invalidCustomerMoreFieldsData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires'! !

!ImportTest methodsFor: 'test data' stamp: 'lm 6/26/2022 23:57:41'!
invalidImportAddressData

	^ ReadStream on: 
'C,Pepe,Sanchez,D,22333444
AA,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'lm 6/23/2022 20:41:22'!
invalidImportCustomerData

	^ ReadStream on: 'CC,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'lm 6/23/2022 20:46:16'!
invalidImportEmptyData

	^ReadStream on: ''.! !

!ImportTest methodsFor: 'test data' stamp: 'lm 6/27/2022 00:14:46'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream newCustomer line record'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'HAW 5/22/2022 18:06:47'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'lm 6/27/2022 00:09:03'!
assertRecordFieldsQuantityIs: aPositiveInteger.

	^(record size = aPositiveInteger) ifFalse: [self error: self class invalidFieldsQuantity].
	
! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'lm 6/26/2022 23:56:01'!
assertThatAddressesCanBeImported

^ newCustomer isNil ifTrue: [self error: self class addressMustBelongToCustomer].
	! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'lm 6/26/2022 23:58:30'!
createRecord

	self isRecordCustomer ifTrue: [^self importCustomer ].

	self isRecordAddress ifTrue: [^self importAddress ].
	
	self error: self class invalidRecordType.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'lm 6/27/2022 00:29:20'!
hasLineToRead

	
	line := readStream nextLine.
	^line notNil! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'lm 6/27/2022 00:09:35'!
importAddress

	| newAddress |
	
	self assertThatAddressesCanBeImported.
	self assertRecordFieldsQuantityIs: 6.
	
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: record second.
			newAddress streetNumber: record third asNumber .
			newAddress town: record fourth.
			newAddress zipCode: record fifth asNumber .
			newAddress province: record sixth! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'lm 6/27/2022 00:09:46'!
importCustomer
	
	self assertRecordFieldsQuantityIs: 5.
	
			newCustomer := Customer new.
			newCustomer firstName: record second.
			newCustomer lastName: record third.
			newCustomer identificationType: record fourth.
			newCustomer identificationNumber: record fifth.
			session persist: newCustomer! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'lm 6/23/2022 20:02:25'!
importRecord

	^ record := line findTokens: $,! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'lm 6/23/2022 20:44:56'!
isRecordAddress

	^ record first = 'A'.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'lm 6/23/2022 20:43:48'!
isRecordCustomer

	^ record first = 'C'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'lm 6/23/2022 20:06:54'!
value
	
	[self hasLineToRead. ] whileTrue: [
		self importRecord.
		self createRecord.		].

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 18:06:47'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'importing' stamp: 'lm 6/26/2022 23:51:28'!
addressMustBelongToCustomer

^'Address must belong to any customer'.! !

!CustomerImporter class methodsFor: 'importing' stamp: 'lm 6/23/2022 20:45:53'!
emptyData

	^'Cannot import empty data'.! !

!CustomerImporter class methodsFor: 'importing' stamp: 'lm 6/23/2022 21:05:14'!
invalidFieldsQuantity

	^'Invalid fields quantity'.! !

!CustomerImporter class methodsFor: 'importing' stamp: 'lm 6/23/2022 20:41:43'!
invalidRecordType

	^'Invalid record type'.! !

!CustomerImporter class methodsFor: 'importing' stamp: 'lm 6/27/2022 00:31:59'!
valueFrom: aReadStream into: aSession

	self streamIsNotEmpty: aReadStream.
	^(self from: aReadStream into: aSession) value! !


!CustomerImporter class methodsFor: 'evaluating' stamp: 'lm 6/27/2022 00:32:52'!
streamIsNotEmpty: aReadStream.

	^ aReadStream isEmpty ifTrue: [ 	self error: self emptyData.]! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
