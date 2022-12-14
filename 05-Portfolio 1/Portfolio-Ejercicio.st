!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'DW 5/16/2022 21:06:10'!
test01PortfolioBalanceIsZero 

	
	self assert: 0 equals: (Portfolio new) balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'DW 5/19/2022 20:12:31'!
test02PortfolioWithOneAccountBalance 

	| account portfolio |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	portfolio := Portfolio with: (OrderedCollection with: account).
	
	self assert: account balance equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'DW 5/19/2022 20:13:03'!
test03PortfolioWithTwoAccountsBalance 

	| account1 account2 portfolio |
	
	account1 := ReceptiveAccount  new.
	Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount  new.
	Deposit register: 200 on: account2.
	
	portfolio := Portfolio with: (OrderedCollection with: account1 with: account2).
	
	self assert: (account1 balance + account2 balance) equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/21/2022 13:33:20'!
test04PortfolioWithTwoAccountsAndAPortfolioBalance 

	| account1 account2 account3 portfolio1 portfolio2 |
	
	account1 := ReceptiveAccount  new.
	Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount  new.
	Deposit register: 200 on: account2.
	
	portfolio1 := Portfolio with: (OrderedCollection with: account1 with: account2).
	
	account3 := ReceptiveAccount  new.
	Deposit register: 200 on: account3.
	
	portfolio2 := Portfolio with: (OrderedCollection with: account3 with: portfolio1).
	
	self assert: portfolio2 balance = (account3 balance + portfolio1 balance).
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/21/2022 13:35:48'!
test05EmptyPortfolioHasNotRegisteredATransaction
	
	|account portfolio transaction |
	
	account := ReceptiveAccount  new.
	transaction := Deposit register: 100 on: account.
	
	portfolio := Portfolio new.
	
	self deny: (portfolio hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/21/2022 14:32:00'!
test06PortfolioHasRegisteredATransaction

	| account portfolio transaction |
	
	account := ReceptiveAccount new.
	transaction := Deposit register: 100 on: account.
	
	portfolio := Portfolio with: (OrderedCollection with: account).
	
	self assert: (portfolio hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/21/2022 13:41:27'!
test07PortfolioHasNotRegisteredAnUnknownTransaction

	| portfolio account transaction anotherAccount anotherTransaction|
	
	account := ReceptiveAccount new.
	transaction := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherTransaction := Deposit register: 100 on: anotherAccount.
	
	portfolio := Portfolio with: (OrderedCollection with: account).
	
	self deny: (portfolio hasRegistered: anotherTransaction).! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/21/2022 14:24:18'!
test08EmptyPortfolioTransactionsAreEmpty

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: portfolio transactions isEmpty.! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/21/2022 14:31:29'!
test09PortfolioWithOneAccountTransactions

	| account deposit withdraw portfolio |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
	
	portfolio := Portfolio with: (OrderedCollection with: account).
	
	self assert: portfolio transactions = (OrderedCollection with: deposit with: withdraw).! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/21/2022 14:31:09'!
test10PortfolioWithOneAccountAndOnePortfolioTransactions

	| account deposit withdraw portfolio |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
	
	portfolio := Portfolio with: (OrderedCollection with: (Portfolio with: (OrderedCollection with: account))).
	
	self assert: portfolio transactions = (OrderedCollection with: deposit with: withdraw).! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/23/2022 00:22:21'!
test11addAccountToPortfolio

	| portfolio account |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	
	portfolio add: account.
	
	self assert: (portfolio checkExistance: account).! !

!PortfolioTest methodsFor: 'tests' stamp: 'DW 5/19/2022 20:44:30'!
test12balanceAfterAddingAccountToPortfolio

	| portfolio account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio new.
	
	portfolio add: account.
	
	self assert: portfolio balance = account balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/23/2022 00:22:41'!
test13addPortfolioToPortfolio

	| portfolio1 portfolio2 |
	
	portfolio2 := Portfolio new.
	portfolio1 := Portfolio new.
	
	portfolio1 add: portfolio2.
	
	self assert: (portfolio1 checkExistance: portfolio2).! !

!PortfolioTest methodsFor: 'tests' stamp: 'DW 5/19/2022 20:46:26'!
test14balanceAfterAddingPortfolioToPortfolio


	| portfolio1 portfolio2 account |
	
	portfolio2 := Portfolio new.
	portfolio1 := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio1 add: account.
	
	portfolio2 add: portfolio1.
	
	self assert: portfolio2 balance = portfolio1 balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'DW 5/19/2022 20:47:36'!
test15balanceAfterAddingPortfolioAndAccountToPortfolio


	| portfolio1 portfolio2 account1 account2 |
	
	portfolio2 := Portfolio new.
	portfolio1 := Portfolio new.

	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	
	portfolio1 add: account1.
	
	portfolio2 add: portfolio1.

	account2 := ReceptiveAccount new.
	Deposit register: 300 on: account2.
	
	portfolio2 add: account2.
	
	self assert: portfolio2 balance = (portfolio1 balance + account2 balance).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/21/2022 14:48:53'!
test16cannotAddTheSameAccountToRootPortfolioTwice

	| portfolio account |
	
	account := ReceptiveAccount new.
	
	portfolio := Portfolio with: (OrderedCollection with: account).
	
	[portfolio add: account] on: Error do:[ :anError | self assert: anError messageText = Portfolio MessageCannotAddToPortfolio.].
	
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/21/2022 14:59:11'!
test17cannotAddAPortfolioThatRepeatsAnAccountInRootPortfolio

	| rootPortfolio portfolio account |
	
	account := ReceptiveAccount new.
	
	rootPortfolio := Portfolio with: (OrderedCollection with: account).
	
	portfolio := Portfolio with: (OrderedCollection with: account).
	
		[rootPortfolio add: portfolio. 
		self fail.] 
				on: Error do:[ :anError | self assert: anError messageText = Portfolio MessageCannotAddToPortfolio.].
	
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/22/2022 23:30:48'!
test18cannotAddAPortfolioIfAlreadyExistsInRelatedPortfolio

	| rootPortfolio portfolio childrenPortfolio |
	
	childrenPortfolio := Portfolio new.
	portfolio := Portfolio new.
	rootPortfolio := Portfolio with: (OrderedCollection with: childrenPortfolio with: portfolio).
	
		[portfolio add: childrenPortfolio. 
		self fail.] 
				on: Error do:[ :anError | self assert: anError messageText = Portfolio MessageCannotAddToPortfolio.].
	
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/22/2022 23:32:21'!
test19cannotAddAnAccountIfAlreadyExistsInRelatedPortfolio

	| rootPortfolio portfolio account |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	rootPortfolio := Portfolio with: (OrderedCollection with: account with: portfolio).
	
		[portfolio add: account. 
		self fail.] 
				on: Error do:[ :anError | self assert: anError messageText = Portfolio MessageCannotAddToPortfolio.].
	
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/22/2022 23:47:04'!
test20cannotAddAnAccountIfAlreadyExistsInAnyRelatedPortfolio

	| rootPortfolio1 rootPortfolio2 portfolio account |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	rootPortfolio1 := Portfolio with: (OrderedCollection with: account with: portfolio).
	rootPortfolio2  := Portfolio with: (OrderedCollection with: portfolio).
	
		[portfolio add: account. 
		self fail.] 
				on: Error do:[ :anError | self assert: anError messageText = Portfolio MessageCannotAddToPortfolio.].
	
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/23/2022 00:08:53'!
test21cannotCreateCyclingPortfolios

	| portfolio1 portfolio2 portfolio3 portfolio4 |
	
	portfolio4 := Portfolio new.
	portfolio3 := Portfolio with: (OrderedCollection with: portfolio4).
	portfolio2 := Portfolio with: (	OrderedCollection  with: portfolio3).
	portfolio1 := Portfolio with: (OrderedCollection with: portfolio2).
	
		[portfolio4 add: portfolio1. 
		self fail.] 
				on: Error do:[ :anError | self assert: anError messageText = Portfolio MessageCannotAddToPortfolio.].
	
	
! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/16/2022 16:18:39'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/16/2022 16:19:11'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
	
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LM 5/23/2022 00:19:22'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions checkExistance: deposit1).
! !


!classDefinition: #Account category: 'Portfolio-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Account methodsFor: 'as yet unclassified' stamp: 'LM 5/21/2022 13:12:15'!
balance

^ self subclassResponsibility.! !

!Account methodsFor: 'as yet unclassified' stamp: 'LM 5/21/2022 13:20:06'!
hasRegistered: aTransaction

	^ self subclassResponsibility.! !

!Account methodsFor: 'as yet unclassified' stamp: 'LM 5/22/2022 21:42:19'!
transactions

	^ self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parentPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'LM 5/23/2022 00:10:53'!
balance

	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ].! !

!Portfolio methodsFor: 'balance' stamp: 'LM 5/23/2022 00:19:22'!
canAddReceptiveAccount: aReceptiveAccount


	(self parents isEmpty) ifTrue: [^ (self checkExistance: aReceptiveAccount) not].
	
	^ self parents allSatisfy: [ :aParentPorfolio | aParentPorfolio canAddReceptiveAccount: aReceptiveAccount].
! !

!Portfolio methodsFor: 'balance' stamp: 'LM 5/23/2022 00:11:18'!
hasRegistered: aTransaction

	^ accounts anySatisfy: [:anAccount | anAccount hasRegistered: aTransaction].! !

!Portfolio methodsFor: 'balance' stamp: 'LM 5/22/2022 23:11:41'!
initialize

	accounts := OrderedCollection new.
	parentPortfolios  := OrderedCollection new.! !

!Portfolio methodsFor: 'balance' stamp: 'LM 5/23/2022 00:11:35'!
initializeWith: aCollectionOfAccounts

	accounts := aCollectionOfAccounts.
	accounts do: [ :anAccount | anAccount addParentPortfolio: self].
! !

!Portfolio methodsFor: 'balance' stamp: 'LM 5/23/2022 00:11:53'!
transactions

	| transactions |
	
	transactions := OrderedCollection new.
	
	accounts do:[ :anAccount | anAccount transactions do: [ :aTransaction | transactions addLast: aTransaction ] ].
	
	^transactions.! !


!Portfolio methodsFor: 'assertion' stamp: 'LM 5/23/2022 00:21:46'!
checkExistance: anAccountToCheck

	^ (accounts includes: anAccountToCheck ) or: [ accounts anySatisfy: [ :anAccount | anAccount checkExistance: anAccountToCheck].].
	
	
	! !


!Portfolio methodsFor: 'modification' stamp: 'LM 5/22/2022 23:03:51'!
add: anAccount
	
	(anAccount canAddTo: self) ifFalse: [^self error: Portfolio MessageCannotAddToPortfolio].
	
	anAccount addParentPortfolio: self.
	accounts addLast: anAccount.! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'LM 5/22/2022 23:23:18'!
addParentPortfolio: aPortfolio

 parentPortfolios addLast: aPortfolio.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'LM 5/23/2022 00:19:22'!
canAddTo: aPortfolio


	
	(aPortfolio parents isEmpty) ifTrue: [^ (aPortfolio checkExistance: self) not and: [accounts allSatisfy: [:subaccount | subaccount canAddTo: aPortfolio]]].
	
	^ aPortfolio parents allSatisfy: [ :aParentPorfolio | self canAddTo: aParentPorfolio ].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'LM 5/22/2022 23:27:19'!
parents

	^ parentPortfolios ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'DW 5/19/2022 21:41:03'!
MessageCannotAddToPortfolio

	^ 'Cannot add element to portfolio'.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'DW 5/16/2022 21:14:20'!
with: anArrayOfPortfolioElements

	^Portfolio new initializeWith: anArrayOfPortfolioElements .! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions parentPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'LM 5/22/2022 23:01:23'!
addParentPortfolio: aPortfolio

 ^ parentPortfolios addLast: aPortfolio.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'LM 5/22/2022 23:12:03'!
initialize

	transactions := OrderedCollection new.
	parentPortfolios  := 	OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'DW 5/16/2022 20:40:47'!
balance
	| balance |
	balance := 0.
	
	transactions do: [ :aTransaction | balance := aTransaction updateBalance: balance ].
	
	^balance .! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'LM 5/23/2022 00:19:22'!
checkExistance: anAccount
	^ self = anAccount.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'LM 5/23/2022 00:21:30'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'LM 5/22/2022 22:14:55'!
canAddTo: aPortfolio

	^ aPortfolio canAddReceptiveAccount: self.! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'DW 5/16/2022 20:39:17'!
updateBalance: aBalance

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'DW 5/16/2022 20:39:47'!
updateBalance: aBalance

	^aBalance + self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'DW 5/16/2022 20:39:55'!
updateBalance: aBalance

	^aBalance - self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !
