!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #Base category: 'Stack-Exercise'!
Object subclass: #Base
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Base methodsFor: 'as yet unclassified' stamp: 'BB 4/27/2022 00:17:22'!
doesNotHaveElementOnTop

	^true.! !

!Base methodsFor: 'as yet unclassified' stamp: 'BB 4/27/2022 00:25:05'!
elementOnTopOfMe

	^self error: OOStack stackEmptyErrorDescription.! !

!Base methodsFor: 'as yet unclassified' stamp: 'BB 4/27/2022 00:12:50'!
holderOnBottomOfMe

	^nil.! !


!classDefinition: #ElementHolder category: 'Stack-Exercise'!
Object subclass: #ElementHolder
	instanceVariableNames: 'elementOnTop holderOnBottom'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ElementHolder methodsFor: 'as yet unclassified' stamp: 'BB 4/27/2022 00:17:30'!
doesNotHaveElementOnTop

	^false.! !

!ElementHolder methodsFor: 'as yet unclassified' stamp: 'BB 4/26/2022 23:51:32'!
elementOnTopOfMe

	^elementOnTop.! !

!ElementHolder methodsFor: 'as yet unclassified' stamp: 'BB 4/26/2022 23:51:27'!
holderOnBottomOfMe

	^holderOnBottom.! !

!ElementHolder methodsFor: 'as yet unclassified' stamp: 'BB 4/26/2022 23:59:27'!
initalizeWithElementOnTop: aString andHolderOnBottom: aHolder

	elementOnTop:= aString.
	holderOnBottom := aHolder.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElementHolder class' category: 'Stack-Exercise'!
ElementHolder class
	instanceVariableNames: ''!

!ElementHolder class methodsFor: 'as yet unclassified' stamp: 'BB 4/26/2022 23:58:52'!
withElementOnTop: aString andHolderOnBottom: aHolder

	^self new initalizeWithElementOnTop: aString andHolderOnBottom: aHolder.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'head size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'BB 4/27/2022 00:18:52'!
initialize

	size := 0.
	head := Base new.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'BB 4/27/2022 00:26:44'!
isEmpty

	^size = 0.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'BB 4/27/2022 00:24:00'!
pop

	| oldHead |
	
	oldHead:= head.
	
	head:= oldHead holderOnBottomOfMe.

	size:= size - 1.

	^oldHead elementOnTopOfMe.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'BB 4/27/2022 00:19:18'!
push: aString

	size:= size + 1.

	^head:= ElementHolder withElementOnTop: aString andHolderOnBottom: head.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'BB 4/27/2022 00:21:32'!
size

	^size.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'BB 4/26/2022 23:53:34'!
top

	^head elementOnTopOfMe.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
