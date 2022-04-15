!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'BB 4/15/2022 19:14:04'!
assertThatCustomerBook: customerBook hasNumberOfActiveCustomers: numberOfActiveCustomers hasNumberOfSuspendedCustomers: numberOfSuspendedCustomers hasNumberOfCustomers: numberOfCustomers

	self assert: numberOfActiveCustomers equals: customerBook numberOfActiveCustomers.
	self assert: numberOfSuspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: numberOfCustomers equals: customerBook numberOfCustomers.

	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LM 4/11/2022 21:46:39'!
assertThatCustomerBook: customerBook hasNumberOfCustomers: numberOfCustomers andIncludesCustomerNamed: customerName

	self assert: customerBook numberOfCustomers = numberOfCustomers.
	self assert: (customerBook includesCustomerNamed: customerName)! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LM 4/11/2022 21:43:05'!
assertThatDoingThis: closure takesLessThanMiliseconds: timeInMiliseconds

	| millisecondsBeforeRunning  millisecondsAfterRunning|
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	closure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^(millisecondsAfterRunning-millisecondsBeforeRunning) < (timeInMiliseconds * millisecond)! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LM 4/11/2022 21:42:46'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	customerBook := CustomerBook new.

	self assertThatDoingThis: [customerBook addCustomerNamed: 'John Lennon'.] takesLessThanMiliseconds: 50.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LM 4/11/2022 21:43:48'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	
	self assertThatDoingThis: [customerBook removeCustomerNamed: paulMcCartney.] takesLessThanMiliseconds: 100.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HernanWilkinson 5/9/2012 18:12'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LM 4/11/2022 21:47:52'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assertThatCustomerBook: customerBook hasNumberOfCustomers: 1 andIncludesCustomerNamed: johnLennon  ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'BB 4/15/2022 19:15:12'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertThatCustomerBook: customerBook hasNumberOfActiveCustomers: 0 hasNumberOfSuspendedCustomers: 1 hasNumberOfCustomers: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'BB 4/15/2022 19:14:58'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertThatCustomerBook: customerBook hasNumberOfActiveCustomers: 0 hasNumberOfSuspendedCustomers: 0 hasNumberOfCustomers: 0. 
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LM 4/11/2022 21:48:27'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: 'George Harrison'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assertThatCustomerBook: customerBook hasNumberOfCustomers: 1 andIncludesCustomerNamed: johnLennon  ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LM 4/11/2022 21:47:07'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: johnLennon.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assertThatCustomerBook: customerBook hasNumberOfCustomers: 1 andIncludesCustomerNamed: johnLennon ]
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'BB 4/15/2022 19:15:42'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'BB 4/15/2022 19:16:19'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'BB 4/15/2022 20:27:56'!
removeCustomerNamed: aName 
 
	(self includesCustomerNamed: aName) ifFalse: [^NotFound signal].

	self removeCustomerNamed: aName fromCustomerCollection: active.

	self removeCustomerNamed: aName fromCustomerCollection: suspended.! !

!CustomerBook methodsFor: 'customer management' stamp: 'BB 4/15/2022 20:27:26'!
removeCustomerNamed: aName fromCustomerCollection: aCollection 

	1 to: aCollection size do: 	
	[ :index |
		aName = (aCollection at: index)
		ifTrue: [
			aCollection removeAt: index.
			^ aName 
		].
	].
	! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:12'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
