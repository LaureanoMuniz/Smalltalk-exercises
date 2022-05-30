!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/30/2022 16:49:29'!
test16NewPortfolioAccountSummary

	| portfolio |
	
	
	portfolio := Portfolio new.
	
	self assert: (AccountSummaryCalculator new reportAnAccount: portfolio) = 'Balance = 0.'.! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/30/2022 16:55:02'!
test17PortfolioWithEmptyAccountSummary

	| portfolio account |
	
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	self assert: (AccountSummaryCalculator new reportAnAccount: portfolio) = 'Balance = 0.'.! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/30/2022 16:54:44'!
test18PortfolioWithOneAccountSummary

	| portfolio account |
	
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on:  account .
	 
	self assert: ((AccountSummaryCalculator new reportAnAccount: portfolio) = 'Depósito por 100. Balance = 100.').! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LM 5/30/2022 16:35:27'!
test08EmptyAccountSummary

	| account |
	
	account := ReceptiveAccount new.
	
	self assert: (AccountSummaryCalculator new reportAnAccount: account) = 'Balance = 0.'.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LM 5/30/2022 16:26:57'!
test09AccountSummaryOneDeposit

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	 
	self assert: ((AccountSummaryCalculator new reportAnAccount: account) = 'Depósito por 100. Balance = 100.').! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LM 5/30/2022 16:28:42'!
test10AccountSummaryTwoDepositOneWithdraw

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Deposit register: 1500 on: account.
	Withdraw register: 100 on: account.
	
	 
	self assert: (AccountSummaryCalculator new reportAnAccount: account)  = 'Depósito por 100. Depósito por 1500. Extracción por 100. Balance = 1500.'.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LM 5/30/2022 16:28:56'!
test11AccountSummaryTwoDepositOneWithdrawAndATransferenceSending

	| account accountReceptor |
	
	account := ReceptiveAccount new.
	accountReceptor := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Deposit register: 1500 on: account.
	Withdraw register: 100 on: account.
	Transference from: account to: accountReceptor  amount: 100.
	
	 
	self assert: (AccountSummaryCalculator new reportAnAccount: account) =  'Depósito por 100. Depósito por 1500. Extracción por 100. Salida por transferencia de 100. Balance = 1400.'.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LM 5/30/2022 16:29:12'!
test12AccountSummaryTwoDepositOneWithdrawOneTransferenceSendingAndATransferenceReception

	| account accountReceptor accountSender |
	
	account := ReceptiveAccount new.
	accountReceptor := ReceptiveAccount new.
	accountSender := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Deposit register: 1500 on: account.
	Withdraw register: 100 on: account.
	Transference from: account to: accountReceptor  amount: 100.
	Transference from: accountSender to: account  amount: 100.
	
	 
	self assert: (AccountSummaryCalculator new reportAnAccount: account) = 'Depósito por 100. Depósito por 1500. Extracción por 100. Salida por transferencia de 100. Entrada por transferencia de 100. Balance = 1500.'.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LM 5/30/2022 16:36:11'!
test13transferNetZero

	| account |
	
	account := ReceptiveAccount new.
	
	self assert: (TransferNetCalculator new reportAnAccount: account) = 0.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LM 5/30/2022 16:36:22'!
test14transferNetOneTransferSending

	| account  accountReceptor |
	
	account := ReceptiveAccount new.
	accountReceptor := ReceptiveAccount new.
	Transference from: account to: accountReceptor  amount: 100.
	 
	self assert: (TransferNetCalculator new reportAnAccount: account) =-100.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LM 5/30/2022 16:36:32'!
test15transferNetOneSendingAndOneRecepting

	| account accountSender accountReceptor |
	
	account := ReceptiveAccount new.
	accountReceptor := ReceptiveAccount new.
	accountSender := ReceptiveAccount new.
	Transference from: account to: accountReceptor  amount: 100.
	Transference from: accountSender to: account  amount: 50.
	self assert: (TransferNetCalculator new reportAnAccount: account) =-50.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LM 5/30/2022 16:36:40'!
test16transferNetOneSendingOneReceptingAndADeposit

	| account accountSender accountReceptor |
	
	account := ReceptiveAccount new.
	accountReceptor := ReceptiveAccount new.
	accountSender := ReceptiveAccount new.
	Transference from: account to: accountReceptor  amount: 100.
	Transference from: accountSender to: account  amount: 50.
	Deposit register: 100 on: account.
	self assert: (TransferNetCalculator new reportAnAccount: account) =-50.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LM 5/30/2022 16:36:46'!
test17transferNetOneSendingOneReceptingOneDepositAndAWithdraw

	| account accountSender accountReceptor |
	
	account := ReceptiveAccount new.
	accountReceptor := ReceptiveAccount new.
	accountSender := ReceptiveAccount new.
	Transference from: account to: accountReceptor  amount: 100.
	Transference from: accountSender to: account  amount: 50.
	Deposit register: 100 on: account.
	Withdraw register: 100 on: account.
	self assert: (TransferNetCalculator new reportAnAccount: account) =-50.! !


!classDefinition: #TransferenceTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceTest methodsFor: 'tests' stamp: 'lm 5/23/2022 21:26:06'!
test01transferenceChangesBalance

	|account1 account2|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Transference from: account1 to: account2 amount: 100.
	
	self assert: (account1 balance = -100 and: [account2 balance = 100.]).
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'lm 5/27/2022 19:44:25'!
test02bothAccountsRegisterTheAccount

	|account1 account2 transference |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transference := Transference from: account1 to: account2 amount: 100.

	self assert: (account1 hasRegistered: transference sending).
	self assert: (account2 hasRegistered: transference reception).! !

!TransferenceTest methodsFor: 'tests' stamp: 'lm 5/27/2022 19:56:58'!
test03cannotTransferWithAmountLessOrEqualThanZero

	|account1 account2 transference |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.



	self should: [ Transference from: account1 to: account2 amount: 0]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Transference canNotTransferWithInvalidAmount equals: anError messageText.].
		
	self should: [ Transference from: account1 to: account2 amount: -100]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: Transference canNotTransferWithInvalidAmount equals: anError messageText.]! !

!TransferenceTest methodsFor: 'tests' stamp: 'lm 5/27/2022 20:01:29'!
test04cannotTransferToYourself

	|account |
	
	account := ReceptiveAccount new.
	

	self should: [ Transference from: account to: account amount: 100]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Transference canNotTransferToYourself equals: anError messageText.].
		
	! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'LM 5/30/2022 16:15:33'!
childrenDoOperation: aOperation


	^ aOperation reportAccounts: accounts .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'information' stamp: 'LM 5/30/2022 16:14:54'!
childrenDoOperation: aOperation


	^ aOperation reportTransactions: transactions.! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'information' stamp: 'BB 5/29/2022 22:30:22'!
calculateTransactionInformationForAccount: anInformationCalculatorForAccount

	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'information' stamp: 'BB 5/29/2022 22:29:59'!
calculateTransactionInformationForAccount: anInformationCalculatorForAccount

	^anInformationCalculatorForAccount calculateInformationForDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferenceReception category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferenceReception
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceReception methodsFor: 'initialization' stamp: 'lm 5/27/2022 19:39:46'!
initializeWith: aTransference

	transference  := aTransference.! !


!TransferenceReception methodsFor: 'value' stamp: 'lm 5/27/2022 19:41:05'!
value
	
	^ transference value.! !


!TransferenceReception methodsFor: 'balance' stamp: 'lm 5/27/2022 19:42:05'!
affectBalance: aBalance

	^aBalance + self value. ! !


!TransferenceReception methodsFor: 'information' stamp: 'BB 5/29/2022 22:30:22'!
calculateTransactionInformationForAccount: anInformationCalculatorForAccount

	^anInformationCalculatorForAccount calculateInformationForTransferenceReception: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceReception class' category: 'Portfolio-Solucion'!
TransferenceReception class
	instanceVariableNames: ''!

!TransferenceReception class methodsFor: 'as yet unclassified' stamp: 'lm 5/27/2022 19:40:18'!
with: aTransference

	^ self new initializeWith: aTransference.! !


!classDefinition: #TransferenceSending category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferenceSending
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceSending methodsFor: 'initialization' stamp: 'lm 5/27/2022 19:39:38'!
initializeWith: aTransference

	transference  := aTransference.! !


!TransferenceSending methodsFor: 'value' stamp: 'lm 5/27/2022 19:41:19'!
value

	^ transference value.! !


!TransferenceSending methodsFor: 'balance' stamp: 'lm 5/27/2022 19:42:19'!
affectBalance: aBalance

	^aBalance - self value.! !


!TransferenceSending methodsFor: 'information' stamp: 'BB 5/29/2022 22:30:22'!
calculateTransactionInformationForAccount: anInformationCalculatorForAccount

	^anInformationCalculatorForAccount calculateInformationForTransferenceSending: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceSending class' category: 'Portfolio-Solucion'!
TransferenceSending class
	instanceVariableNames: ''!

!TransferenceSending class methodsFor: 'as yet unclassified' stamp: 'lm 5/27/2022 19:39:04'!
with: aTransference

	^ self new initializeWith: aTransference.! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'information' stamp: 'BB 5/29/2022 22:30:22'!
calculateTransactionInformationForAccount: anInformationCalculatorForAccount

	^anInformationCalculatorForAccount calculateInformationForWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #InformationCalculatorForAccount category: 'Portfolio-Solucion'!
Object subclass: #InformationCalculatorForAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!InformationCalculatorForAccount methodsFor: 'as yet unclassified' stamp: 'BB 5/29/2022 22:32:56'!
calculateInformationForDeposit: aDeposit

	^self subclassResponsibility.! !

!InformationCalculatorForAccount methodsFor: 'as yet unclassified' stamp: 'BB 5/29/2022 22:33:11'!
calculateInformationForTransferenceReception: aTransferenceReception

	^self subclassResponsibility.! !

!InformationCalculatorForAccount methodsFor: 'as yet unclassified' stamp: 'BB 5/29/2022 22:33:27'!
calculateInformationForTransferenceSending: aTransferenceSending

	^self subclassResponsibility.! !

!InformationCalculatorForAccount methodsFor: 'as yet unclassified' stamp: 'BB 5/29/2022 22:33:45'!
calculateInformationForWithdraw: aWithdraw

	^self subclassResponsibility.! !


!classDefinition: #AccountSummaryCalculator category: 'Portfolio-Solucion'!
InformationCalculatorForAccount subclass: #AccountSummaryCalculator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryCalculator methodsFor: 'as yet unclassified' stamp: 'BB 5/29/2022 22:31:56'!
calculateInformationForDeposit: aDeposit

	^'Depósito por ', aDeposit value asString, '. '! !

!AccountSummaryCalculator methodsFor: 'as yet unclassified' stamp: 'BB 5/29/2022 22:31:59'!
calculateInformationForTransferenceReception: aTransferenceReception

	^'Entrada por transferencia de ', aTransferenceReception value asString, '. '! !

!AccountSummaryCalculator methodsFor: 'as yet unclassified' stamp: 'BB 5/29/2022 22:32:03'!
calculateInformationForTransferenceSending: aTransferenceSending 
	
	^'Salida por transferencia de ', aTransferenceSending value asString, '. '! !

!AccountSummaryCalculator methodsFor: 'as yet unclassified' stamp: 'BB 5/29/2022 22:32:07'!
calculateInformationForWithdraw: aWithdraw

	^'Extracción por ', aWithdraw value asString, '. '! !

!AccountSummaryCalculator methodsFor: 'as yet unclassified' stamp: 'LM 5/30/2022 16:52:22'!
reportAccounts: aListOfAccounts

	 |individualSummarys|
	individualSummarys  := ''.
	aListOfAccounts do: [ :anAccount | individualSummarys  := individualSummarys , anAccount childrenDoOperation: self].
	
	^ individualSummarys.
	! !

!AccountSummaryCalculator methodsFor: 'as yet unclassified' stamp: 'LM 5/30/2022 16:34:49'!
reportAnAccount: anAccount

	|individualReports|	
	
	individualReports := anAccount childrenDoOperation: self.
	
	^ individualReports  , 'Balance = ' , anAccount  balance asString , '.'.! !

!AccountSummaryCalculator methodsFor: 'as yet unclassified' stamp: 'LM 5/30/2022 16:45:10'!
reportTransactions: aListOfTransactions

	| summary|
	
	summary  := ''.
	aListOfTransactions do: [ :aTransaction | 
		summary:= summary , (aTransaction calculateTransactionInformationForAccount: self).
	].

	^ summary.! !


!classDefinition: #TransferNetCalculator category: 'Portfolio-Solucion'!
InformationCalculatorForAccount subclass: #TransferNetCalculator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetCalculator methodsFor: 'as yet unclassified' stamp: 'BB 5/29/2022 22:32:22'!
calculateInformationForDeposit: aDeposit

	^0.! !

!TransferNetCalculator methodsFor: 'as yet unclassified' stamp: 'BB 5/29/2022 22:32:25'!
calculateInformationForTransferenceReception: aTransferenceReception

	^aTransferenceReception value.! !

!TransferNetCalculator methodsFor: 'as yet unclassified' stamp: 'BB 5/29/2022 22:32:29'!
calculateInformationForTransferenceSending: aTransferenceSending

	^aTransferenceSending value * -1.! !

!TransferNetCalculator methodsFor: 'as yet unclassified' stamp: 'BB 5/29/2022 22:32:33'!
calculateInformationForWithdraw: aWithdraw

	^0.! !

!TransferNetCalculator methodsFor: 'as yet unclassified' stamp: 'LM 5/30/2022 16:31:16'!
reportAnAccount: anAccount

	^ anAccount childrenDoOperation: self.! !

!TransferNetCalculator methodsFor: 'as yet unclassified' stamp: 'LM 5/30/2022 16:30:41'!
reportTransactions: aListOfTransactions



	^ aListOfTransactions inject: 0
		into: [ :currentTransferNet :transaction | currentTransferNet + (transaction calculateTransactionInformationForAccount: self)].! !


!classDefinition: #Transference category: 'Portfolio-Solucion'!
Object subclass: #Transference
	instanceVariableNames: 'value sending reception'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transference methodsFor: 'as yet unclassified' stamp: 'lm 5/27/2022 19:36:26'!
initializeFrom: aSenderAccount to: aReceptorAccount withAmount: anAmountOfMoney

	
	reception := TransferenceReception with: self.
	sending := TransferenceSending with: self.
	value  := anAmountOfMoney.! !

!Transference methodsFor: 'as yet unclassified' stamp: 'lm 5/27/2022 19:36:53'!
reception

	^ reception.! !

!Transference methodsFor: 'as yet unclassified' stamp: 'lm 5/27/2022 19:37:03'!
sending

	^ sending .! !

!Transference methodsFor: 'as yet unclassified' stamp: 'lm 5/27/2022 19:37:20'!
value

	^ value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'Portfolio-Solucion'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'initialization' stamp: 'lm 5/27/2022 19:58:45'!
canNotTransferToYourself

	^ 'Cannot transfer to yourself'! !

!Transference class methodsFor: 'initialization' stamp: 'lm 5/27/2022 19:55:16'!
canNotTransferWithInvalidAmount

	^ 'Cannot transfer with invalid amount of money'! !

!Transference class methodsFor: 'initialization' stamp: 'lm 5/27/2022 20:00:02'!
from: aSenderAccount to: aReceptorAccount amount: anAmountOfMoney

	|transference|
	
	(anAmountOfMoney <= 0) ifTrue: [ self error: Transference canNotTransferWithInvalidAmount].
	(aSenderAccount = aReceptorAccount ) ifTrue: [self error: Transference canNotTransferToYourself].
	
	transference := self new initializeFrom: aSenderAccount to: aReceptorAccount  withAmount: anAmountOfMoney. 

	aReceptorAccount register: transference reception.
	aSenderAccount register: transference sending.
	
	^ transference.! !
