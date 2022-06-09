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

!CardTest methodsFor: 'test' stamp: 'lm 6/9/2022 12:07:55'!
test01cannotCreateDebitCardWithEmptyName

	self 
		should: [ Card withName: '' expirationDateYear:2022 expirationDateMonth: 6 number: '1234123412341234']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Card cannotCreateCardWithEmptyName . ].! !

!CardTest methodsFor: 'test' stamp: 'lm 6/9/2022 12:08:14'!
test02cannotCreateDebitCardWithSpacesAtTheBeginingOrEnd

	self 
		should: [ Card withName: '  Nombre ' expirationDateYear: 2022 expirationDateMonth: 6 number: '1234123412341234']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Card cannotCreateCardWithNameWithSpaces. ].! !

!CardTest methodsFor: 'test' stamp: 'lm 6/9/2022 12:08:26'!
test03cannotCreateDebitCardWithNumberNotOf16Characters

	self 
		should: [ Card withName: 'Nombre' expirationDateYear: 2022 expirationDateMonth: 6 number: '12341234123412345']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Card cannotCreateCardWithInvalidNumber. ].! !

!CardTest methodsFor: 'test' stamp: 'lm 6/9/2022 12:08:40'!
test04cannotCreateDebitCardWithCharactersDifferentThanDigits

	self 
		should: [ Card withName: 'Nombre' expirationDateYear: 2022 expirationDateMonth: 6 number: '12a41234e34!!2_45']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Card cannotCreateCardWithInvalidCharacters. ].! !

!CardTest methodsFor: 'test' stamp: 'lm 6/9/2022 12:08:48'!
test05cannotCreateDebitCardWithLongName

	self 
		should: [ Card withName: 'Nombreeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee' expirationDateYear: 2022 expirationDateMonth: 6 number: '1234123412341234']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Card cannotCreateCardWithinvalidNameLength. ].! !

!CardTest methodsFor: 'test' stamp: 'lm 6/9/2022 13:05:47'!
test06cannotAddNonPositiveAmountOfMoney
	
	
	| card |
	card := Card withName: 'Nombre' expirationDateYear: GregorianMonthOfYear current year number expirationDateMonth: GregorianMonthOfYear current month number number: '1234123412341234'.
	self 
		should: [ card addMoney: 0]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Card cannotAddNonPositiveAmountOfMoney. ].! !


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
	instanceVariableNames: 'expiredCard cashier catalog cart card merchantMock bank'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'test' stamp: 'lm 6/9/2022 15:58:28'!
setUp
	
	catalog := Dictionary with: ('Libro1'->10) with: ('Libro2'->20) with: ('Libro3'->30) with: ('LibroQueCuestaMasDe16Cifras'->12345678901234567).
	cart := Cart withCatalog: catalog.
	
	card := Card withName: 'Nombre' expirationDateYear: GregorianMonthOfYear current year number expirationDateMonth: GregorianMonthOfYear current month number number: '1234123412341235'.
	expiredCard := Card withName: 'Nombre' expirationDateYear:GregorianMonthOfYear current previous year number expirationDateMonth: GregorianMonthOfYear current previous month number number: '1234123412341234'.
	
	bank := Bank withDebitCards: (OrderedCollection with: card with: expiredCard).
	merchantMock := MerchantMock withBank: bank.
	cashier := Cashier withMerchant: merchantMock.! !

!CashierTest methodsFor: 'test' stamp: 'lm 6/9/2022 13:19:46'!
test01checkoutEmptyCart

	
	card addMoney: 50.
	self 
		should: [  cashier checkOut: cart withCard: card]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: cashier cannotCheckOutEmptyCart.
			self assert: cart isEmpty.
			self assert: card money = 50 ]
	
	! !

!CashierTest methodsFor: 'test' stamp: 'lm 6/9/2022 13:21:09'!
test02checkoutCartWithOneElement

	

	cart addToCart: 'Libro1' quantity: 1.
	card addMoney: 50 + cart calculateTotal.
	
	self assert: ('0|OK' = (cashier checkOut: cart withCard: card )).
	self assert: card money = 50.
	
	! !

!CashierTest methodsFor: 'test' stamp: 'lm 6/9/2022 13:16:21'!
test03checkoutCartWithManyElements

	
	
	cart addToCart: 'Libro1' quantity: 1.
	cart addToCart: 'Libro2' quantity: 2.
	cart addToCart: 'Libro3' quantity: 1.
	card addMoney: cart calculateTotal.
	
	self assert: ('0|OK' = (cashier checkOut: cart withCard: card)).
	self assert: card money = 0.! !

!CashierTest methodsFor: 'test' stamp: 'lm 6/9/2022 14:25:03'!
test04checkoutCartWithExpiratedCard

	
	cart addToCart: 'Libro1' quantity: 1.
	cart addToCart: 'Libro2' quantity: 2.
	cart addToCart: 'Libro3' quantity: 1.

	card addMoney: 50.
	self 
		should: [ cashier checkOut: cart withCard: expiredCard]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: cashier cannotCheckOutWithExpiratedCard. 
			self assert: card money = 50.]
	! !

!CashierTest methodsFor: 'test' stamp: 'lm 6/9/2022 14:42:25'!
test05checkoutCartWithAmountToDebitGreaterThanCardFunds

	
	cart addToCart: 'Libro1' quantity: 1.
	cart addToCart: 'Libro2' quantity: 2.
	cart addToCart: 'Libro3' quantity: 1.

	card addMoney: cart calculateTotal - 50.
	self assert: '1|ERROR ON DEBIT' equals: (cashier checkOut: cart withCard: card).
	self assert: card money = (cart calculateTotal - 50).
		! !

!CashierTest methodsFor: 'test' stamp: 'lm 6/9/2022 16:22:02'!
test06checkoutCartWithAmountToDebitMoreThan16Digits

	
	cart addToCart: 'Libro1' quantity: 1.
	cart addToCart: 'Libro2' quantity: 2.
	cart addToCart: 'LibroQueCuestaMasDe16Cifras' quantity: 1.

	card addMoney: cart calculateTotal - 50.
	self 
		should: [ cashier checkOut: cart withCard: card]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: cashier amountToDebitMustHaveLessThan16Digits.
			self assert: card money = (cart calculateTotal - 50).]
	! !


!classDefinition: #MerchantMockTest category: 'TusLibros'!
LibroTest subclass: #MerchantMockTest
	instanceVariableNames: 'expiredCard cashier catalog cart card merchantMock bank'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantMockTest methodsFor: 'as yet unclassified' stamp: 'lm 6/9/2022 16:06:43'!
setUp
	
	
	catalog := Dictionary with: ('Libro1'->10) with: ('Libro2'->20) with: ('Libro3'->30).
	cart := Cart withCatalog: catalog.
	
	card := Card withName: 'Nombre' expirationDateYear: GregorianMonthOfYear current year number expirationDateMonth: GregorianMonthOfYear current month number number: '1234123412341235'.
	expiredCard := Card withName: 'Nombre' expirationDateYear:GregorianMonthOfYear current previous year number expirationDateMonth: GregorianMonthOfYear current previous month number number: '1234123412341234'.
	bank := Bank withDebitCards: (OrderedCollection with: card with: expiredCard).
	merchantMock := MerchantMock withBank: bank.
	cashier := Cashier withMerchant: merchantMock.! !

!MerchantMockTest methodsFor: 'as yet unclassified' stamp: 'lm 6/9/2022 15:05:06'!
test01invalidNameLength
	
	self assert: '1|ERROR ON NAME' equals: (merchantMock debitTransactionAmout: (cart calculateTotal) debitCardNumber: (card cardNumber) debitCardExpiration: (card expirationYear asString, '/', card expirationMonth asString) debitCardOwner: 'NOMBREDEMASIADOLARGOPARAHACERELREQUESTALMERCHANTPROCESSOR').! !

!MerchantMockTest methodsFor: 'as yet unclassified' stamp: 'lm 6/9/2022 15:08:47'!
test02emptyName
	
	self assert: '1|ERROR ON NAME' equals: (merchantMock debitTransactionAmout: (cart calculateTotal) debitCardNumber: (card cardNumber) debitCardExpiration: (card expirationYear asString, '/', card expirationMonth asString) debitCardOwner: '').! !

!MerchantMockTest methodsFor: 'as yet unclassified' stamp: 'lm 6/9/2022 15:10:49'!
test03blankSpacesAtBeginningOrEnd
	
	self assert: '1|ERROR ON NAME' equals: (merchantMock debitTransactionAmout: (cart calculateTotal) debitCardNumber: (card cardNumber) debitCardExpiration: (card expirationYear asString, '/', card expirationMonth asString) debitCardOwner: ' Nombre ').! !

!MerchantMockTest methodsFor: 'as yet unclassified' stamp: 'lm 6/9/2022 15:21:09'!
test04invalidDebitCardNumberLength
	
	self assert: '1|ERROR ON CARD NUMBER' equals: (merchantMock debitTransactionAmout: (cart calculateTotal) debitCardNumber: '1234123412341' debitCardExpiration: (card expirationYear asString, '/', card expirationMonth asString) debitCardOwner: card ownerName ).! !

!MerchantMockTest methodsFor: 'as yet unclassified' stamp: 'lm 6/9/2022 15:21:39'!
test05invalidDebitCardNumberCharacters
	
	self assert: '1|ERROR ON CARD NUMBER' equals: (merchantMock debitTransactionAmout: (cart calculateTotal) debitCardNumber: '123412&412341' debitCardExpiration: (card expirationYear asString, '/', card expirationMonth asString) debitCardOwner: card ownerName ).! !

!MerchantMockTest methodsFor: 'as yet unclassified' stamp: 'lm 6/9/2022 15:46:42'!
test06invalidDebitCardExpirationMonthFormat
	
	self assert: '1|ERROR ON DATE' equals: (merchantMock debitTransactionAmout: (cart calculateTotal) debitCardNumber: card cardNumber debitCardExpiration: '2022/1' debitCardOwner: card ownerName ).! !

!MerchantMockTest methodsFor: 'as yet unclassified' stamp: 'lm 6/9/2022 15:46:55'!
test07invalidDebitCardExpirationYearFormat
	
	self assert: '1|ERROR ON DATE' equals: (merchantMock debitTransactionAmout: (cart calculateTotal) debitCardNumber: card cardNumber debitCardExpiration: '22/10' debitCardOwner: card ownerName ).! !

!MerchantMockTest methodsFor: 'as yet unclassified' stamp: 'lm 6/9/2022 15:47:35'!
test08invalidDebitCardExpirationSeparator
	
	self assert: '1|ERROR ON DATE' equals: (merchantMock debitTransactionAmout: (cart calculateTotal) debitCardNumber: card cardNumber debitCardExpiration: '2022-10' debitCardOwner: card ownerName ).! !

!MerchantMockTest methodsFor: 'as yet unclassified' stamp: 'lm 6/9/2022 16:07:58'!
test09debitCardAmountMoreThan16Digits
	
	self assert: '1|ERROR ON AMOUNT' equals: (merchantMock debitTransactionAmout: '1234567890123456.00' debitCardNumber: card cardNumber debitCardExpiration: '2022/10' debitCardOwner: card ownerName ).! !


!classDefinition: #Bank category: 'TusLibros'!
Object subclass: #Bank
	instanceVariableNames: 'debitCards'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Bank methodsFor: 'as yet unclassified' stamp: 'lm 6/9/2022 16:23:42'!
debitAmount: anAmountToDebitAsString debitCardNumber: aDebitCardNumber debitCardExpiration: aDebitCardExpiration debitCardOwner: aDebitCardOwner
	
	debitCards do: [:debitCard | (aDebitCardNumber isEqualTo: debitCard cardNumber) ifTrue: [debitCard debitMoney: anAmountToDebitAsString asNumber]].! !

!Bank methodsFor: 'as yet unclassified' stamp: 'lm 6/9/2022 13:49:51'!
withDebitAccounts: aSetOfDebitCards


	debitCards := aSetOfDebitCards.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Bank class' category: 'TusLibros'!
Bank class
	instanceVariableNames: ''!

!Bank class methodsFor: 'as yet unclassified' stamp: 'lm 6/9/2022 14:05:52'!
withDebitCards: aSetOfDebitCards

	^self new withDebitAccounts: aSetOfDebitCards.! !


!classDefinition: #Card category: 'TusLibros'!
Object subclass: #Card
	instanceVariableNames: 'ownerName expirationDate number savedMoney'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Card methodsFor: 'initialization' stamp: 'lm 6/9/2022 13:04:01'!
addMoney: anAmountOfMoney

	self validateMoney: anAmountOfMoney.
	
	savedMoney := savedMoney + anAmountOfMoney.! !

!Card methodsFor: 'initialization' stamp: 'lm 6/9/2022 13:02:17'!
initalizeWithName: aName expirationDate: aDate number: aDebitCardNumber

	ownerName := aName.
	expirationDate := aDate.
	number := aDebitCardNumber.
	savedMoney := 0.! !


!Card methodsFor: 'accessing' stamp: 'BB 6/9/2022 01:30:20'!
cardNumber

	^number copy.! !

!Card methodsFor: 'accessing' stamp: 'BB 6/9/2022 01:37:21'!
expirationMonth
	
	^expirationDate month number copy.! !

!Card methodsFor: 'accessing' stamp: 'BB 6/9/2022 01:37:17'!
expirationYear
	
	^expirationDate year number copy.! !

!Card methodsFor: 'accessing' stamp: 'lm 6/9/2022 13:15:23'!
money
	
	^ savedMoney copy.! !

!Card methodsFor: 'accessing' stamp: 'BB 6/9/2022 01:37:38'!
ownerName

	^ownerName copy.! !


!Card methodsFor: 'expired' stamp: 'lm 6/9/2022 12:20:04'!
isExpiredOn: aGregorianMonthOfYear 
	
	^ expirationDate < aGregorianMonthOfYear.	 ! !


!Card methodsFor: 'validation' stamp: 'lm 6/9/2022 13:12:43'!
validateMoney: anAmountOfMoney

 	(anAmountOfMoney <= 0) ifTrue: [self error: self class cannotAddNonPositiveAmountOfMoney ].! !


!Card methodsFor: 'debiting' stamp: 'lm 6/9/2022 14:22:26'!
cannotDebitThatAmountOfMoney

	^'Amount of money to debit cannot be greater than saved money on this account'.! !

!Card methodsFor: 'debiting' stamp: 'lm 6/9/2022 16:24:06'!
debitMoney: anAmountOfMoney
	
	self validateAmountOfMoneyToDebit: anAmountOfMoney.
	
	savedMoney := savedMoney - anAmountOfMoney.! !

!Card methodsFor: 'debiting' stamp: 'lm 6/9/2022 16:24:27'!
validateAmountOfMoneyToDebit: anAmountOfMoney
	
	
	anAmountOfMoney > savedMoney ifTrue: [ self error: self cannotDebitThatAmountOfMoney].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: 'TusLibros'!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'as yet unclassified' stamp: 'lm 6/9/2022 13:01:36'!
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


!Card class methodsFor: 'error' stamp: 'lm 6/9/2022 13:11:42'!
cannotAddNonPositiveAmountOfMoney
	
	^ 'Amount of money to add must be bigger than zero.'.! !

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

!Cashier methodsFor: 'checkout' stamp: 'lm 6/9/2022 16:13:43'!
amountToDebitMustHaveLessThan16Digits

^'Amount to debit must have less than 16 digits'.
	! !

!Cashier methodsFor: 'checkout' stamp: 'lm 6/9/2022 16:17:45'!
checkOut: aCart withCard: aCard 

	aCart isEmpty ifTrue: [self error: self cannotCheckOutEmptyCart].
	(aCard isExpiredOn: GregorianMonthOfYear current) ifTrue: [self error: self cannotCheckOutWithExpiratedCard].
	self validateAmount: (aCart calculateTotal asString).
	
	^merchant debitTransactionAmout: (aCart calculateTotal asString,'.00') debitCardNumber: (aCard cardNumber) debitCardExpiration: (self formatExpirationDateOf: aCard) debitCardOwner: aCard ownerName.! !

!Cashier methodsFor: 'checkout' stamp: 'lm 6/9/2022 15:51:24'!
formatExpirationDateOf: aCard 

	
	 (aCard expirationMonth asString size < 2 ) ifTrue: [^ (aCard expirationYear asString, '/0', aCard expirationMonth asString)].
	
	^ (aCard expirationYear asString, '/', aCard expirationMonth asString).! !

!Cashier methodsFor: 'checkout' stamp: 'lm 6/9/2022 16:13:12'!
validateAmount: anAmountOfMoney

	anAmountOfMoney size > 15 ifTrue: [self error: self amountToDebitMustHaveLessThan16Digits].
	! !


!Cashier methodsFor: 'error' stamp: 'lm 6/6/2022 19:34:55'!
cannotCheckOutEmptyCart
	
	^'Cannot checkOut empty cart'.! !

!Cashier methodsFor: 'error' stamp: 'lm 6/9/2022 12:17:32'!
cannotCheckOutWithExpiratedCard

	^ 'Cannot checkout with a expiratedCard'.! !


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
	instanceVariableNames: 'bank'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantMock methodsFor: 'as yet unclassified' stamp: 'lm 6/9/2022 15:59:44'!
debitTransactionAmout: aTransactionAmout debitCardNumber: aDebitCardNumber debitCardExpiration: aDebitCardExpiration debitCardOwner: aDebitCardOwner

	((self validateName: aDebitCardOwner) = 'INVALID') ifTrue: [ ^'1|ERROR ON NAME'].
	
	((self validateNumber: aDebitCardNumber) = 'INVALID') ifTrue: [ ^'1|ERROR ON CARD NUMBER'].
	
	((self validateCardExpiration: aDebitCardExpiration) = 'INVALID') ifTrue: [ ^'1|ERROR ON DATE'].
	
	((self validateTransactionAmount: aTransactionAmout) = 'INVALID') ifTrue: [ ^'1|ERROR ON AMOUNT'].
	
	[bank debitAmount: aTransactionAmout debitCardNumber: aDebitCardNumber debitCardExpiration: aDebitCardExpiration debitCardOwner: aDebitCardOwner.] on: Error 
	do: [ ^ '1|ERROR ON DEBIT'].	
	
	^'0|OK'.	! !

!MerchantMock methodsFor: 'as yet unclassified' stamp: 'lm 6/9/2022 15:43:47'!
validateCardExpiration: aDebitCardExpiration
	(aDebitCardExpiration size = 7) ifFalse: [^'INVALID'].
	((aDebitCardExpiration copyFrom: 5 to: 5) = '/') ifFalse: [ ^'INVALID'].
	((self validateYear: (aDebitCardExpiration copyFrom: 1 to: 4)) = 'INVALID') ifTrue: [ ^'INVALID'].
	((self validateMonth: (aDebitCardExpiration copyFrom: 6 to: 7)) = 'INVALID') ifTrue: [ ^'INVALID'].! !

!MerchantMock methodsFor: 'as yet unclassified' stamp: 'lm 6/9/2022 15:41:30'!
validateMonth: aMonth
	
	(aMonth size = 2) ifFalse:  [^'INVALID'].
	(aMonth asNumber < 1 or: [aMonth asNumber > 12] )ifTrue: [^'INVALID'].
	(aMonth allSatisfy: [:aCharacter | aCharacter isDigit]) ifFalse: [^'INVALID'].! !

!MerchantMock methodsFor: 'as yet unclassified' stamp: 'lm 6/9/2022 15:20:41'!
validateName: aName 
	
	(aName isEmpty) ifTrue: [^'INVALID'].

	(((aName at: 1) asString = ' ') or: [(aName at: (aName size)) asString = ' ']) ifTrue: [^'INVALID'].
	
	(aName size <= 30) ifFalse: [^'INVALID'].! !

!MerchantMock methodsFor: 'as yet unclassified' stamp: 'lm 6/9/2022 15:18:45'!
validateNumber: aDebitCardNumber
	
	(aDebitCardNumber size = 16) ifFalse: [^'INVALID'].
	
	(aDebitCardNumber allSatisfy: [:aCharacter | aCharacter isDigit]) ifFalse: [^'INVALID'].! !

!MerchantMock methodsFor: 'as yet unclassified' stamp: 'lm 6/9/2022 16:09:12'!
validateTransactionAmount: aTransactionAmout
	
	(aTransactionAmout size > 18) ifTrue: [^'INVALID'].! !

!MerchantMock methodsFor: 'as yet unclassified' stamp: 'lm 6/9/2022 15:53:19'!
validateYear: aMonth
	
	(aMonth size = 4) ifFalse:  [^'INVALID'].
	(aMonth asNumber < GregorianYear current number) ifTrue: [^'INVALID'].
	(aMonth allSatisfy: [:aCharacter | aCharacter isDigit]) ifFalse: [^'INVALID'].! !

!MerchantMock methodsFor: 'as yet unclassified' stamp: 'lm 6/9/2022 13:52:05'!
withBank: aBank

	bank := aBank.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantMock class' category: 'TusLibros'!
MerchantMock class
	instanceVariableNames: ''!

!MerchantMock class methodsFor: 'as yet unclassified' stamp: 'lm 6/9/2022 14:04:35'!
withBank: aBank

	^self new withBank: aBank.! !
