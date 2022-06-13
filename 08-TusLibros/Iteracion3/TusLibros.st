!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'BB 6/13/2022 01:40:00'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook
			toClient: testObjectsFactory clientId.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'BB 6/13/2022 01:40:17'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new
		toClient: testObjectsFactory clientId.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'BB 6/13/2022 01:45:41'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook
				toClient: testObjectsFactory clientId. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'BB 6/13/2022 01:45:48'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook
		toClient: testObjectsFactory clientId.

	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'BB 6/13/2022 01:45:52'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook
		toClient: testObjectsFactory clientId.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'BB 6/13/2022 01:45:58'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook
		toClient: testObjectsFactory clientId.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #InterfaceTest category: 'TusLibros'!
TestCase subclass: #InterfaceTest
	instanceVariableNames: 'authenticatorBehavior debitBehavior timeBehaviour factory interface'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InterfaceTest methodsFor: 'test' stamp: 'LM 6/13/2022 12:11:26'!
itemNotSellByTheStore

	^ factory itemNotSellByTheStore! !

!InterfaceTest methodsFor: 'test' stamp: 'LM 6/13/2022 12:11:16'!
itemSellByTheStore

	^ factory itemSellByTheStore! !

!InterfaceTest methodsFor: 'test' stamp: 'LM 6/13/2022 14:56:09'!
setUp

	factory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ].
	authenticatorBehavior := [ :aClientId :aPassword | true].
	timeBehaviour := [:actualTime | true]. 
	interface := Interface withCatalog: factory defaultCatalog withAuthenticator: self withTimeProvider: self withMerchantProcessor: self.! !


!InterfaceTest methodsFor: 'merchant date auth protocol' stamp: 'BB 6/13/2022 03:06:47'!
authenticateClientWithId: aClientId andPassword: aPassword

	^authenticatorBehavior value: aClientId value: aPassword.! !

!InterfaceTest methodsFor: 'merchant date auth protocol' stamp: 'BB 6/13/2022 02:37:18'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard.! !

!InterfaceTest methodsFor: 'merchant date auth protocol' stamp: 'LM 6/13/2022 14:55:43'!
is30MinutesBeforeToNow: actualTime.

	^timeBehaviour value: actualTime.! !

!InterfaceTest methodsFor: 'merchant date auth protocol' stamp: 'LM 6/13/2022 13:49:24'!
today

	^factory today.! !

!InterfaceTest methodsFor: 'merchant date auth protocol' stamp: 'LM 6/13/2022 14:55:34'!
updateLastTimeOperation
	
	! !


!InterfaceTest methodsFor: 'test - list purchases' stamp: 'LM 6/13/2022 16:17:26'!
test18listPurchasesOfUserWithNoPurchasesIsEmpty


 self assert: (interface listPurchasesForClient: factory clientId withPassword: factory clientPassword) isEmpty.! !

!InterfaceTest methodsFor: 'test - list purchases' stamp: 'LM 6/13/2022 16:17:33'!
test19listPurchasesOfAClientWithOnlyOneCheckout

	
	| cartId  card listOfPurchases |
	
	
	cartId := interface createCartWithClientId: factory clientId andPassword: factory clientPassword.
	card := factory notExpiredCreditCard.
	interface addToCartWithId: cartId bookIsbn: self itemSellByTheStore bookQuantity: 2.
	interface checkOutcartWithId: cartId creditCardNumber: factory creditCardNumber creditCardExpirationDate: card expiration withOwner: factory clientId.
	
	listOfPurchases := interface listPurchasesForClient: factory clientId withPassword: factory clientPassword.
	
	self assert: listOfPurchases size = 2.
	
			! !

!InterfaceTest methodsFor: 'test - list purchases' stamp: 'LM 6/13/2022 16:17:44'!
test20listPurchasesOfAClientWithMultipleCheckOuts

	
	| cartId  card listOfPurchases |
	
	
	cartId := interface createCartWithClientId: 	factory clientId andPassword: factory clientPassword.
	card := factory notExpiredCreditCard.
	
	interface addToCartWithId: cartId bookIsbn: self itemSellByTheStore bookQuantity: 1.
	interface checkOutcartWithId: cartId creditCardNumber: factory creditCardNumber creditCardExpirationDate: card expiration withOwner: factory clientId.
	
	cartId := interface createCartWithClientId: 	factory clientId andPassword: factory clientPassword.
	
	interface addToCartWithId: cartId bookIsbn: self itemSellByTheStore bookQuantity: 2.
	interface checkOutcartWithId: cartId creditCardNumber: factory creditCardNumber creditCardExpirationDate: card expiration withOwner: factory clientId.
	
	listOfPurchases := interface listPurchasesForClient: factory clientId withPassword: factory clientPassword.
	
	self assert: listOfPurchases size = 3.
	
			! !

!InterfaceTest methodsFor: 'test - list purchases' stamp: 'LM 6/13/2022 16:17:59'!
test21cannotListPurchasesWithInvalidCredentials

	authenticatorBehavior := [ :aClientId :aPassword | false ].
	self 
			should: [interface listPurchasesForClient: factory clientId withPassword:  factory clientPassword.]
			raise: Error - MessageNotUnderstood
			withExceptionDo: [ :anError |
				self assert: anError messageText = Interface invalidUserData .]
		! !


!InterfaceTest methodsFor: 'test - list cart' stamp: 'LM 6/13/2022 16:16:34'!
test08listCartWithManyBooks
	
	| cartId |
	
	
	cartId := interface createCartWithClientId: factory clientId andPassword: factory clientPassword.
	
	interface addToCartWithId: cartId bookIsbn: self itemSellByTheStore bookQuantity: 2.
	
	self assert: ((interface listCart: cartId) = (OrderedCollection with: self itemSellByTheStore with: self itemSellByTheStore )).! !

!InterfaceTest methodsFor: 'test - list cart' stamp: 'LM 6/13/2022 16:16:38'!
test09listCartWithManyBooksAndManyAdditions
	
	| cartId |
	
	
	cartId := interface createCartWithClientId: factory clientId andPassword: factory clientPassword.
	
	interface addToCartWithId: cartId bookIsbn: self itemSellByTheStore bookQuantity: 2.
	interface addToCartWithId: cartId bookIsbn: self itemSellByTheStore bookQuantity: 1.
	
	self assert: ((interface listCart: cartId) = (OrderedCollection with: self itemSellByTheStore with: self itemSellByTheStore with: self itemSellByTheStore)).! !

!InterfaceTest methodsFor: 'test - list cart' stamp: 'LM 6/13/2022 15:47:52'!
test10cannotListCartIfNotCreated
	
	| cartId |

	cartId := nil.

	self 
		should: [(interface listCart: cartId)]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interface cartNotCreated .]! !


!InterfaceTest methodsFor: 'test - create cart' stamp: 'LM 6/13/2022 16:16:08'!
test01createEmptyCartSucceeded

	| cartId |
	
	cartId := interface createCartWithClientId: 	factory clientId andPassword: factory clientPassword.
	
	self assert: (interface listCart: cartId) isEmpty.! !

!InterfaceTest methodsFor: 'test - create cart' stamp: 'LM 6/13/2022 16:16:12'!
test02cannotCreateCartWithInvalidCredentials

	
	authenticatorBehavior := [ :aClientId :aPassword | false ].
	
	self 
		should: [interface createCartWithClientId: factory clientId andPassword: factory clientPassword.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interface invalidUserData.]! !

!InterfaceTest methodsFor: 'test - create cart' stamp: 'LM 6/13/2022 16:16:20'!
test03createCartUsesDifferentCartIds

	| cartId1 cartId2 |
	
	
	cartId1 := interface createCartWithClientId: factory clientId andPassword: factory clientPassword.
	cartId2 := interface createCartWithClientId: factory clientId andPassword: factory clientPassword.
	
	self deny: cartId1 = cartId2! !


!InterfaceTest methodsFor: 'test - add to cart' stamp: 'LM 6/13/2022 16:16:24'!
test04canAddItemsToCreatedCart

	| cartId |
	
	cartId := interface createCartWithClientId: factory clientId andPassword: factory clientPassword.
	
	interface addToCartWithId: cartId bookIsbn: self itemSellByTheStore bookQuantity: 2.
	
	self assert: (((interface listCart: cartId) occurrencesOf: self itemSellByTheStore) = 2).! !

!InterfaceTest methodsFor: 'test - add to cart' stamp: 'LM 6/13/2022 15:46:06'!
test05cannotAddItemToNotCreatedCart

	| cartId |
	
	authenticatorBehavior := [ :aClientId :aPassword | true].
	
	cartId := nil.

	self 
		should: [interface addToCartWithId: cartId bookIsbn: self itemSellByTheStore bookQuantity: 2.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interface cartNotCreated.]! !

!InterfaceTest methodsFor: 'test - add to cart' stamp: 'LM 6/13/2022 16:16:27'!
test06cannotAdditemNotSellByStore
	
	| cartId |
	
	
	cartId := interface createCartWithClientId: factory clientId andPassword: factory clientPassword.
	
	self 
		should: [interface addToCartWithId: cartId bookIsbn: self itemNotSellByTheStore bookQuantity: 2.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interface canNotAdditemNotSellByStore.]! !

!InterfaceTest methodsFor: 'test - add to cart' stamp: 'LM 6/13/2022 16:16:31'!
test07cannotAddItemToCartWhen30MinutesHavePassed
	
	| cartId |
	
	
	cartId := interface createCartWithClientId: 	factory clientId andPassword: factory clientPassword.
	
	timeBehaviour := [:actualTime | false].
	
	self 
		should: [interface addToCartWithId: cartId bookIsbn: self itemSellByTheStore bookQuantity: 1.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interface cartHasAlreadyExpiredMessage .]
	
	
	
	! !


!InterfaceTest methodsFor: 'test - checkout' stamp: 'LM 6/13/2022 16:16:45'!
test11checkOutCartWithOnlyOneAddition
	
	| cartId card |
	
	
	cartId := interface createCartWithClientId: 	factory clientId andPassword: factory clientPassword.
	
	interface addToCartWithId: cartId bookIsbn: self itemSellByTheStore bookQuantity: 1.
	
	card := factory notExpiredCreditCard.
	
	interface checkOutcartWithId: cartId creditCardNumber: factory creditCardNumber creditCardExpirationDate: card expiration withOwner: factory clientId.
	
	self assert: (interface listPurchasesForClient: factory clientId withPassword:  factory clientPassword) = (OrderedCollection with: self itemSellByTheStore ).! !

!InterfaceTest methodsFor: 'test - checkout' stamp: 'LM 6/13/2022 16:16:53'!
test12checkOutCartWithManyAdditions
	
	| cartId card |
	
	
	cartId := interface createCartWithClientId: factory clientId andPassword: factory clientPassword.
	
	interface addToCartWithId: cartId bookIsbn: self itemSellByTheStore bookQuantity: 1.
	
	interface addToCartWithId: cartId bookIsbn: self itemSellByTheStore bookQuantity: 2.
	
	card := factory notExpiredCreditCard.
	
	interface checkOutcartWithId: cartId creditCardNumber: factory creditCardNumber creditCardExpirationDate: card expiration withOwner: factory clientId.
	
	self assert: (interface listPurchasesForClient: factory clientId withPassword:  factory clientPassword) = (OrderedCollection with: self itemSellByTheStore with: self itemSellByTheStore with: self itemSellByTheStore ).! !

!InterfaceTest methodsFor: 'test - checkout' stamp: 'LM 6/13/2022 16:16:58'!
test13cannotCheckOutWithEmptyCart
	
	| cartId card |
	

	cartId := interface createCartWithClientId: 	factory clientId andPassword: factory clientPassword.
	
	card := factory notExpiredCreditCard.
	
	self 
		should: [interface checkOutcartWithId: cartId creditCardNumber: factory creditCardNumber creditCardExpirationDate: card expiration withOwner: factory clientId.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage .]
	
	
	
	! !

!InterfaceTest methodsFor: 'test - checkout' stamp: 'LM 6/13/2022 16:17:02'!
test14cannotCheckOutWhenTheCreditCardHasNoCredit
	
	| cartId card |
	

	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage ].
	cartId := interface createCartWithClientId: 	factory clientId andPassword: factory clientPassword.
	
	interface addToCartWithId: cartId bookIsbn: self itemSellByTheStore bookQuantity: 1.
	
	card := factory notExpiredCreditCard.
	
	self 
		should: [interface checkOutcartWithId: cartId creditCardNumber: factory creditCardNumber creditCardExpirationDate: card expiration withOwner: factory clientId.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText =  Cashier creditCardHasNoCreditErrorMessage .]
	
	
	
	! !

!InterfaceTest methodsFor: 'test - checkout' stamp: 'LM 6/13/2022 16:17:06'!
test15cannotAddItemToCartWhen30MinutesHavePassed
	
	| cartId card |
	
	
	cartId := interface createCartWithClientId: 	factory clientId andPassword: factory clientPassword.
	
	card := factory notExpiredCreditCard.
	
	timeBehaviour := [:actualTime | false].
	
	self 
		should: [interface addToCartWithId: cartId bookIsbn: self itemSellByTheStore bookQuantity: 1.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interface cartHasAlreadyExpiredMessage .]
	
	
	
	! !

!InterfaceTest methodsFor: 'test - checkout' stamp: 'LM 6/13/2022 16:17:11'!
test16cannotCheckOutWithExpiredCard
	
	| cartId card |
	
	
	
	cartId := interface createCartWithClientId: factory clientId andPassword: factory clientPassword.
	
	interface addToCartWithId: cartId bookIsbn: self itemSellByTheStore bookQuantity: 1.
	
	card := factory expiredCreditCard.
	
	self 
		should: [interface checkOutcartWithId: cartId creditCardNumber: factory creditCardNumber creditCardExpirationDate: card expiration withOwner: factory clientId.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.]
	
	
	
	! !

!InterfaceTest methodsFor: 'test - checkout' stamp: 'LM 6/13/2022 16:17:22'!
test17cannotCheckOutACartTwice
	
	| cartId card |
	
	
	cartId := interface createCartWithClientId: factory clientId andPassword: factory clientPassword.
	
	interface addToCartWithId: cartId bookIsbn: self itemSellByTheStore bookQuantity: 1.
	
	card := factory notExpiredCreditCard .
	interface checkOutcartWithId: cartId creditCardNumber: factory creditCardNumber creditCardExpirationDate: card expiration withOwner: factory clientId.
	self 
		should: [interface checkOutcartWithId: cartId creditCardNumber: factory creditCardNumber creditCardExpirationDate: card expiration withOwner: factory clientId.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interface cannotCheckOutInvalidCartId .]
	
	
	
	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'DW 6/9/2022 21:26:03'!
items

	^items copy.! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total client'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'BB 6/13/2022 03:35:40'!
createSale

	^ Sale of: total withItems: (cart items)  forClient: client.
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'BB 6/13/2022 01:39:10'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook toClient: clientId
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.
	client := clientId.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'BB 6/13/2022 01:39:24'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook toClient: clientId
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook toClient: clientId.! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !


!CreditCard methodsFor: 'accessing' stamp: 'BB 6/13/2022 03:03:18'!
expiration
	
	^expiration copy.! !


!CreditCard methodsFor: 'nil' stamp: 'LM 6/13/2022 13:15:48'!
= anotherCreditCard

^ true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #Interface category: 'TusLibros'!
Object subclass: #Interface
	instanceVariableNames: 'catalog authenticator carts nextCartId purchasesBook merchantProcessor lastOperationTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Interface methodsFor: 'cart creation' stamp: 'LM 6/13/2022 14:23:17'!
createCartWithClientId: aClientId andPassword: aPassword
 	
	(authenticator authenticateClientWithId: aClientId andPassword: aPassword) ifFalse: [self error: Interface invalidUserData].
	
	nextCartId := nextCartId + 1.
	
	carts add: (nextCartId->(Cart acceptingItemsOf: catalog)).
	lastOperationTime updateLastTimeOperation.
	^nextCartId.! !


!Interface methodsFor: 'initalization' stamp: 'LM 6/13/2022 14:20:08'!
initializeWithCatalog: aCatalog withAuthenticator: anAuthenticator withDateProvider: aDateProvider withMerchantProcessor: aMerchantProcessor
	
	catalog := aCatalog.
	authenticator := anAuthenticator.
	carts := Dictionary new.
	nextCartId := 1.
	purchasesBook := Dictionary new.
	lastOperationTime := aDateProvider.
	merchantProcessor:= aMerchantProcessor.! !


!Interface methodsFor: 'accessing' stamp: 'LM 6/13/2022 14:41:19'!
listCart: aCartId
	
	(lastOperationTime is30MinutesBeforeToNow: (Time now)) ifFalse: [self error: Interface cartHasAlreadyExpiredMessage.].
	
	(carts includesKey: aCartId) ifFalse: [self error: Interface cartNotCreated].
	lastOperationTime updateLastTimeOperation.
	^(carts at: aCartId) items.! !


!Interface methodsFor: 'checkout' stamp: 'LM 6/13/2022 15:40:39'!
checkOutcartWithId: cartId creditCardNumber: aCreditCardNumber creditCardExpirationDate: aDate withOwner: clientId

	| cart creditCard salesBook cashier |
	
	(lastOperationTime is30MinutesBeforeToNow: (Time now)) ifFalse: [self error: Interface cartHasAlreadyExpiredMessage.].
	cart := carts at: cartId ifAbsent: [self error: Interface cannotCheckOutInvalidCartId].
	
	creditCard := CreditCard expiringOn: aDate.
	salesBook  := OrderedCollection new.
	cashier := Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: merchantProcessor
		on: lastOperationTime today
		registeringOn: salesBook
		toClient: clientId.
	
	cashier checkOut.
	
	(purchasesBook includesKey: clientId) ifFalse: [purchasesBook add: (clientId->OrderedCollection new)].
	
	
	 salesBook do: [ :aSale | aSale items do: [ :item | (purchasesBook at: clientId) add: item ]].
	
	carts removeKey: cartId
! !


!Interface methodsFor: 'purchases' stamp: 'LM 6/13/2022 16:05:15'!
listPurchasesForClient: aClientId withPassword: aPassword
 
	(authenticator authenticateClientWithId: aClientId andPassword: aPassword) ifFalse: [self error: Interface invalidUserData].
	
	^purchasesBook at: aClientId ifAbsent: [OrderedCollection new].! !


!Interface methodsFor: 'adding' stamp: 'LM 6/13/2022 14:40:44'!
addToCartWithId: aCartId bookIsbn: aBookIsbn bookQuantity: aQuantity 
	
	(lastOperationTime is30MinutesBeforeToNow: (Time now)) ifFalse: [self error: Interface cartHasAlreadyExpiredMessage.].
	(carts includesKey: aCartId) ifFalse: [self error: Interface cartNotCreated].
	(catalog includesKey: aBookIsbn) ifFalse: [self error: Interface canNotAdditemNotSellByStore].
	(carts at: aCartId) add: aQuantity of: aBookIsbn.
	lastOperationTime updateLastTimeOperation.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Interface class' category: 'TusLibros'!
Interface class
	instanceVariableNames: ''!

!Interface class methodsFor: 'as yet unclassified' stamp: 'BB 6/13/2022 00:38:06'!
canNotAdditemNotSellByStore

	^'Can not add item not sell by store'.! !

!Interface class methodsFor: 'as yet unclassified' stamp: 'LM 6/13/2022 13:39:55'!
cartHasAlreadyExpiredMessage

	^'Cart has already expired because last operation was 30 minutes ago'.! !

!Interface class methodsFor: 'as yet unclassified' stamp: 'BB 6/13/2022 00:51:42'!
cartNotCreated

	^'Cart not created'! !

!Interface class methodsFor: 'as yet unclassified' stamp: 'DW 6/9/2022 21:08:21'!
invalidUserData

	^'Invalid user data'.! !

!Interface class methodsFor: 'as yet unclassified' stamp: 'LM 6/13/2022 13:32:24'!
withCatalog: aCatalog withAuthenticator: anAuthenticator withTimeProvider: aDateProvider withMerchantProcessor: aMerchantProcessor

	^self new initializeWithCatalog: aCatalog withAuthenticator: anAuthenticator withDateProvider: aDateProvider withMerchantProcessor: aMerchantProcessor.! !


!Interface class methodsFor: 'purchases' stamp: 'LM 6/13/2022 15:08:43'!
clientDoesNotHaveAnyPurchase

	^ 'Client does not have any purchase yet'.! !


!Interface class methodsFor: 'checkout' stamp: 'LM 6/13/2022 15:41:04'!
cannotCheckOutInvalidCartId

	'Cannot check out with Invalid CartId'.
! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total items client'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

!Sale methodsFor: 'initialization' stamp: 'BB 6/13/2022 03:34:20'!
initializeTotal: aTotal withItems: anItemsCollection forClient: aClientId

	total := aTotal.
	items := anItemsCollection.
	client := aClientId.! !


!Sale methodsFor: 'as yet unclassified' stamp: 'BB 6/13/2022 03:35:04'!
client

	^client copy.! !

!Sale methodsFor: 'as yet unclassified' stamp: 'BB 6/13/2022 03:34:52'!
items

	^items copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !

!Sale class methodsFor: 'instance creation' stamp: 'BB 6/13/2022 03:32:47'!
of: aTotal withItems: items forClient: client

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal withItems: items forClient: client.! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'LM 6/13/2022 13:10:04'!
itemSellByTheStorePrice

	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'BB 6/13/2022 02:35:53'!
creditCardNumber

	^'creditCardNumber'.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'client' stamp: 'DW 6/9/2022 20:24:50'!
clientId

	^'client'! !

!StoreTestObjectsFactory methodsFor: 'client' stamp: 'DW 6/9/2022 20:25:07'!
clientPassword

	^'password'! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
