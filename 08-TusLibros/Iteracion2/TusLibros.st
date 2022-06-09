!classDefinition: #LibroTest category: 'TusLibros'!
TestCase subclass: #LibroTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #CardTest category: 'TusLibros'!
LibroTest subclass: #CardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CardTest methodsFor: 'test' stamp: 'BB 6/9/2022 00:27:07'!
test01cannotCreateCreditCardWithEmptyName

	self 
		should: [ Card withName: '' expirationDateYear:2022 expirationDateMonth: 6 number: '1234123412341234']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Card cannotCreateCardWithEmptyName . ].! !

!CardTest methodsFor: 'test' stamp: 'BB 6/9/2022 00:27:41'!
test02cannotCreateCreditCardWithSpacesAtTheBeginingOrEnd

	self 
		should: [ Card withName: '  Nombre ' expirationDateYear: 2022 expirationDateMonth: 6 number: '1234123412341234']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Card cannotCreateCardWithNameWithSpaces. ].! !

!CardTest methodsFor: 'test' stamp: 'BB 6/9/2022 00:28:06'!
test03cannotCreateCreditCardWithNumberNotOf16Characters

	self 
		should: [ Card withName: 'Nombre' expirationDateYear: 2022 expirationDateMonth: 6 number: '12341234123412345']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Card cannotCreateCardWithInvalidNumber. ].! !

!CardTest methodsFor: 'test' stamp: 'BB 6/9/2022 00:28:39'!
test04cannotCreateCreditCardWithCharactersDifferentThanDigits

	self 
		should: [ Card withName: 'Nombre' expirationDateYear: 2022 expirationDateMonth: 6 number: '12a41234e34!!2_45']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Card cannotCreateCardWithInvalidCharacters. ].! !

!CardTest methodsFor: 'test' stamp: 'BB 6/9/2022 00:33:49'!
test05cannotCreateCreditCardWithLongName

	self 
		should: [ Card withName: 'Nombreeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee' expirationDateYear: 2022 expirationDateMonth: 6 number: '1234123412341234']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Card cannotCreateCardWithinvalidNameLength. ].! !


!classDefinition: #CartTest category: 'TusLibros'!
LibroTest subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'test' stamp: 'LM 6/5/2022 22:27:39'!
test1NewCartIsEmpty

	self assert: Cart new isEmpty.! !

!CartTest methodsFor: 'test' stamp: 'lm 6/6/2022 19:19:27'!
test2CartWithABookIsNotEmpty

	|cart catalog|
	
	catalog := Dictionary with: ('Libro1'->10).
	cart := Cart withCatalog: catalog.

	cart addToCart: 'Libro1' quantity: 1.
	
	self assert: cart isNotEmpty.! !

!CartTest methodsFor: 'test' stamp: 'lm 6/6/2022 19:19:34'!
test3cannotAddBookIfNotInCatalog

	|cart catalog|
	
	catalog := Dictionary new.
	cart := Cart withCatalog: catalog.
	
	self 
		should: [cart addToCart: 'Libro1' quantity: 1. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: cart bookNotInCatalogDescription.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'test' stamp: 'lm 6/6/2022 19:19:41'!
test4bookQuantityToAddMustBeGreaterThanZero

	|cart catalog|
	
	catalog := Dictionary new.
	cart := Cart withCatalog: catalog.
	
	self 
		should: [ cart addToCart: 'Libro1' quantity: 0. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: cart quantityToAddMustBeGreaterThanZero .
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'test' stamp: 'lm 6/6/2022 19:19:46'!
test5bookQuantityOfNotAddedBookShouldBeZero
	|cart catalog|
	
	catalog := Dictionary with: ('Libro1'->10).
	cart := Cart withCatalog: catalog.

	self assert: (cart quantityOf: 'Libro1') = 0. ! !

!CartTest methodsFor: 'test' stamp: 'lm 6/6/2022 19:19:52'!
test6bookQuantityShouldAccumulate
	|cart catalog|
	
	catalog := Dictionary with: ('Libro1'->10).
	cart := Cart withCatalog: catalog.
	
	cart addToCart: 'Libro1' quantity: 7. 
	cart addToCart: 'Libro1' quantity: 3.
	
	self assert: (cart quantityOf: 'Libro1') = 10. ! !

!CartTest methodsFor: 'test' stamp: 'lm 6/6/2022 19:20:00'!
test7listCartOfNewCartShouldBeEmpty
	|cart catalog|
	
	catalog := Dictionary with: ('Libro1'->10).
	cart := Cart withCatalog: catalog.

	
	self assert: (cart listCart isEmpty). ! !

!CartTest methodsFor: 'test' stamp: 'lm 6/6/2022 19:20:11'!
test8listCartWithMultipleBooks
	|cart catalog|
	
	catalog := Dictionary with: ('Libro1'->10) with: ('Libro2' -> 5) with: ('Libro3' -> 15).
	cart := Cart withCatalog: catalog.
	cart addToCart: 'Libro1' quantity: 2.
	cart addToCart: 'Libro2' quantity: 1.
	cart addToCart: 'Libro3' quantity: 7.
	self assert: (cart listCart =  '|Libro1|2|Libro2|1|Libro3|7'). ! !


!classDefinition: #CashierTest category: 'TusLibros'!
LibroTest subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'test' stamp: 'BB 6/9/2022 01:01:23'!
test01checkoutEmptyCart

	| cart cashier card |
	
	cart := Cart new.
	cashier := Cashier new.
	card := Card new.
	
	self 
		should: [ cashier checkOut: cart withCard: card]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: cashier cannotCheckOutEmptyCart.
			self assert: cart isEmpty ]
	
	! !

!CashierTest methodsFor: 'test' stamp: 'BB 6/9/2022 01:09:42'!
test02checkoutCartWithOneElement

	| cart cashier catalog card |

	cashier := Cashier withMerchant: (MerchantMock new).
	catalog := Dictionary with: ('Libro1'->10).
	cart := Cart withCatalog: catalog.
	card := Card withName: 'Nombre' expirationDateYear: 2022 expirationDateMonth: 6 number: '1234123412341234'.

	cart addToCart: 'Libro1' quantity: 1.

	self assert: ('0|OK' = (cashier checkOut: cart withCard: card )).
	
	! !

!CashierTest methodsFor: 'test' stamp: 'BB 6/9/2022 01:41:45'!
test03checkoutCartWithManyElements

	| cart cashier catalog card |

	cashier := Cashier withMerchant: (MerchantMock new).
	catalog := Dictionary with: ('Libro1'->10) with: ('Libro2'->20) with: ('Libro3'->30).
	cart := Cart withCatalog: catalog.
	card := Card withName: 'Nombre' expirationDateYear: 2022 expirationDateMonth: 6 number: '1234123412341234'.
	
	cart addToCart: 'Libro1' quantity: 1.
	cart addToCart: 'Libro2' quantity: 2.
	cart addToCart: 'Libro3' quantity: 1.

	self assert: ('0|OK' = (cashier checkOut: cart withCard: card)).! !


!classDefinition: #Card category: 'TusLibros'!
Object subclass: #Card
	instanceVariableNames: 'ownerName expirationDate number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Card methodsFor: 'initialization' stamp: 'BB 6/9/2022 01:29:26'!
initalizeWithName: aName expirationDate: aDate number: aCreditCardNumber

	ownerName := aName.
	expirationDate := aDate.
	number := aCreditCardNumber.! !


!Card methodsFor: 'accessing' stamp: 'BB 6/9/2022 01:30:20'!
cardNumber

	^number copy.! !

!Card methodsFor: 'accessing' stamp: 'BB 6/9/2022 01:37:21'!
expirationMonth
	
	^expirationDate month number copy.! !

!Card methodsFor: 'accessing' stamp: 'BB 6/9/2022 01:37:17'!
expirationYear
	
	^expirationDate year number copy.! !

!Card methodsFor: 'accessing' stamp: 'BB 6/9/2022 01:37:38'!
ownerName

	^ownerName copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: 'TusLibros'!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'as yet unclassified' stamp: 'BB 6/9/2022 01:28:20'!
withName: aName expirationDateYear: aYear expirationDateMonth: aMonth number: aCreditCardNumber

	self validateName: aName.
	self validateNumber: aCreditCardNumber.

	^self new initalizeWithName: aName expirationDate: (GregorianMonthOfYear yearNumber: aYear monthNumber: aMonth) number: aCreditCardNumber.! !


!Card class methodsFor: 'validation' stamp: 'BB 6/9/2022 00:33:05'!
validateName: aName 
	
	(aName isEmpty) ifTrue: [self error: self cannotCreateCardWithEmptyName].

	(((aName at: 1) asString = ' ') or: [(aName at: (aName size)) asString = ' ']) ifTrue: [self error: self cannotCreateCardWithNameWithSpaces].
	
	(aName size <= 30) ifFalse: [self error: self cannotCreateCardWithinvalidNameLength ].! !

!Card class methodsFor: 'validation' stamp: 'BB 6/9/2022 00:06:42'!
validateNumber: aCreditCardNumber 
	
	(aCreditCardNumber size = 16) ifFalse: [self error: self cannotCreateCardWithInvalidNumber].
	
	(aCreditCardNumber allSatisfy: [:aCharacter | aCharacter isDigit]) ifFalse: [self error: self cannotCreateCardWithInvalidCharacters].! !


!Card class methodsFor: 'error' stamp: 'BB 6/8/2022 23:57:02'!
cannotCreateCardWithEmptyName
	
	^'Cannot create card with empty name'.! !

!Card class methodsFor: 'error' stamp: 'BB 6/9/2022 00:07:25'!
cannotCreateCardWithInvalidCharacters

	^'Credit card number characters must be digits'.! !

!Card class methodsFor: 'error' stamp: 'BB 6/9/2022 00:03:04'!
cannotCreateCardWithInvalidNumber

	^'Credit card number must have 16 characters'.! !

!Card class methodsFor: 'error' stamp: 'BB 6/8/2022 23:45:14'!
cannotCreateCardWithNameWithSpaces
	
	^'Cannot create card with name with spaces.'.! !

!Card class methodsFor: 'error' stamp: 'BB 6/9/2022 00:32:46'!
cannotCreateCardWithinvalidNameLength

	^'Name must have less than 30 characters'.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'items catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'lm 6/6/2022 18:51:54'!
addToCart: aBook quantity: quantityToAdd

	self assertThatBookIsInCatalog: aBook andQuantityToAddIsGreaterThanZero: quantityToAdd.
	
	items add: aBook withOccurrences: quantityToAdd. 
	! !

!Cart methodsFor: 'as yet unclassified' stamp: 'lm 6/6/2022 19:20:28'!
assertThatBookIsInCatalog: aBook andQuantityToAddIsGreaterThanZero: quantityToAdd

	(quantityToAdd < 1) ifTrue: [^self error: self quantityToAddMustBeGreaterThanZero.].
	(catalog keys includes: aBook) ifFalse: [^self error: self bookNotInCatalogDescription]! !

!Cart methodsFor: 'as yet unclassified' stamp: 'LM 6/5/2022 22:50:05'!
bookNotInCatalogDescription

	^ 'This book is not in the catalog'.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'BB 6/8/2022 23:25:11'!
calculateTotal

	^items sortedElements inject: 0 into: [:total :item | total + ((catalog at: (item key) )* (item value) )].	
! !

!Cart methodsFor: 'as yet unclassified' stamp: 'lm 6/6/2022 18:51:00'!
initialize

	items := Bag new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'lm 6/6/2022 18:51:00'!
isEmpty
	^ items size = 0.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'LM 6/5/2022 23:42:19'!
isNotEmpty

	^ (self isEmpty) not.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'lm 6/6/2022 19:14:59'!
listCart

	|listCart|
	
	listCart := String new.
	items sortedElements do: [:assn | listCart := listCart,( '|', assn key asString ,'|', (assn value asString))].
	
	^ listCart.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'lm 6/6/2022 18:53:20'!
quantityOf: aBook

	^ items occurrencesOf: aBook.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'LM 6/5/2022 23:08:46'!
quantityToAddMustBeGreaterThanZero
	
	^'quantity to add must be greater than zero'.! !


!Cart methodsFor: 'initialization' stamp: 'LM 6/5/2022 22:47:16'!
initializeWithCatalog: aCatalog 
	
	catalog := aCatalog.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'LM 6/5/2022 22:47:03'!
withCatalog: aCatalog 

	^self new initializeWithCatalog: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'merchant'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'BB 6/9/2022 01:25:52'!
checkOut: aCart withCard: aCard 

	aCart isEmpty ifTrue: [self error: self cannotCheckOutEmptyCart].
	
		
	^merchant debiTransactionAmout: (aCart calculateTotal) creditCardNumber: (aCard cardNumber) creditCardExpiration: (aCard expirationYear asString, '/', aCard expirationMonth asString) creditCardOwner: aCard ownerName.! !


!Cashier methodsFor: 'error' stamp: 'lm 6/6/2022 19:34:55'!
cannotCheckOutEmptyCart
	
	^'Cannot checkOut empty cart'.! !


!Cashier methodsFor: 'initalization' stamp: 'BB 6/9/2022 00:50:32'!
initializeWithMerchant: aMerchant

	merchant := aMerchant.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'BB 6/9/2022 00:50:02'!
withMerchant: aMerchant

	^self new initializeWithMerchant: aMerchant.! !


!classDefinition: #MerchantMock category: 'TusLibros'!
Object subclass: #MerchantMock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantMock methodsFor: 'as yet unclassified' stamp: 'BB 6/9/2022 01:23:10'!
debiTransactionAmout: aTransactionAmout creditCardNumber: aCreditCardNumber creditCardExpiration: aCreditCardExpiration creditCardOwner: aCreditCardOwner

	^'0|OK'.! !
