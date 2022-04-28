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

!OOStackTest methodsFor: 'test' stamp: 'LM 4/28/2022 15:29:43'!
test11twoEmptyStacksAreEqual

	
	| stack otherStack |

	stack := OOStack new.
	otherStack := OOStack new.

	self assert: (stack isEqualTo: otherStack ).
! !

!OOStackTest methodsFor: 'test' stamp: 'LM 4/28/2022 15:30:39'!
test12twoStackWithSameElementsInSameOrderAreEqual

	| stack otherStack  |

	stack := OOStack new.
	otherStack := OOStack new.
	
	otherStack push: 'holanda'.
	otherStack push: 'hola'.
	otherStack push: 'Smalltalk'.
	
	stack push: 'holanda'.
	stack push: 'hola'.
	stack push: 'Smalltalk'.

	self assert: (stack isEqualTo: otherStack ).! !

!OOStackTest methodsFor: 'test' stamp: 'LM 4/28/2022 15:31:11'!
test13twoStackWithSameElementsInDifferentOrderAreNotEqual

	| stack otherStack  |

	stack := OOStack new.
	otherStack := OOStack new.
	
	otherStack push: 'holanda'.
	otherStack push: 'hola'.
	otherStack push: 'Smalltalk'.
	
	stack push: 'hola'.
	stack push: 'holanda'.
	stack push: 'Smalltalk'.

	self deny: (stack isEqualTo: otherStack ).! !

!OOStackTest methodsFor: 'test' stamp: 'LM 4/28/2022 15:32:12'!
test14twoStackWithDifferentElementsAreNotEqual

	| stack otherStack  |

	stack := OOStack new.
	otherStack := OOStack new.
	
	otherStack push: 'holanda'.
	otherStack push: 'Arroz'.
	otherStack push: 'Smalltalk'.
	
	stack push: 'hola'.
	stack push: 'holanda'.
	stack push: 'Smalltalk'.

	self deny: (stack isEqualTo: otherStack ).! !

!OOStackTest methodsFor: 'test' stamp: 'LM 4/28/2022 15:33:42'!
test15twoStackWithDifferentSizeAreNotEqual

	| stack otherStack  |

	stack := OOStack new.
	otherStack := OOStack new.
	
	otherStack push: 'holanda'.
	otherStack push: 'Smalltalk'.
	
	stack push: 'hola'.
	stack push: 'holanda'.
	stack push: 'Smalltalk'.
	

	self deny: (stack isEqualTo: otherStack ).! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LM 4/28/2022 14:51:07'!
test01stackHasElementsWithPrefix

	| stack prefix expectedSentencesWithPrefix actualSentencesWithPrefix |

	prefix := 'hola'.
	expectedSentencesWithPrefix := OrderedCollection with: 'hola que tal' with: 'holanda' .
	stack := OOStack new.
	
	stack push: 'holanda'.
	stack push: 'hola que tal'.
	stack push: 'la que tal'.

	actualSentencesWithPrefix:= SentenceFinderByPrefix new findSentencesWithPrefix: prefix in: stack.

	self assert: (expectedSentencesWithPrefix hasEqualElements: actualSentencesWithPrefix).
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LM 4/28/2022 14:51:12'!
test02finderIsCaseSensitive

	| stack prefix expectedSentencesWithPrefix actualSentencesWithPrefix |

	prefix := 'HOLA'.
	expectedSentencesWithPrefix := OrderedCollection with: 'HOLAnda' .
	stack := OOStack new.
	
	stack push: 'HOLAnda'.
	stack push: 'Hola que tal'.
	stack push: 'la que tal'.

	actualSentencesWithPrefix:= SentenceFinderByPrefix new findSentencesWithPrefix: prefix in: stack.

	self assert: (expectedSentencesWithPrefix hasEqualElements: actualSentencesWithPrefix).
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LM 4/28/2022 14:51:17'!
test03CannotFoundInEmptyStack
	| stack prefix expectedSentencesWithPrefix actualSentencesWithPrefix |

	prefix := 'HOLA'.
	expectedSentencesWithPrefix := OrderedCollection new .
	stack := OOStack new.
	

	actualSentencesWithPrefix:= SentenceFinderByPrefix new findSentencesWithPrefix: prefix in: stack.

	self assert: (expectedSentencesWithPrefix hasEqualElements: actualSentencesWithPrefix).
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LM 4/28/2022 14:51:21'!
test04CannotFoundInNotEmptyStack
	| stack prefix expectedSentencesWithPrefix actualSentencesWithPrefix |

	prefix := 'HOLA'.
	expectedSentencesWithPrefix := OrderedCollection new .
	stack := OOStack new.
	stack push: 'Blas'.
	stack push: 'Laureano'.

	actualSentencesWithPrefix:= SentenceFinderByPrefix new findSentencesWithPrefix: prefix in: stack.

	self assert: (expectedSentencesWithPrefix hasEqualElements: actualSentencesWithPrefix).
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LM 4/28/2022 14:51:27'!
test05checkStackHasNotBeenModified
	| stack otherStack prefix actualSentencesWithPrefix |

	prefix := 'hola'.
	stack := OOStack new.
	otherStack := OOStack new.
	
	otherStack push: 'holanda'.
	otherStack push: 'hola'.
	otherStack push: 'Smalltalk'.
	
	stack push: 'holanda'.
	stack push: 'hola'.
	stack push: 'Smalltalk'.
	
	actualSentencesWithPrefix:= SentenceFinderByPrefix new findSentencesWithPrefix: prefix in: stack.
	

	self assert: (stack isEqualTo: otherStack ).
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LM 4/28/2022 14:51:45'!
test06EmptyPrefixShouldFail
	| stack prefix actualSentencesWithPrefix |

	prefix := ''.
	stack := OOStack new.
	
	stack push: 'holanda'.
	stack push: 'hola'.
	stack push: 'Smalltalk'.
	
	
	
	self
		should: [ actualSentencesWithPrefix:= SentenceFinderByPrefix new findSentencesWithPrefix: prefix in: 				stack. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix InvalidPrefix].
	

! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LM 4/28/2022 14:52:12'!
test07PrefixWithSpacesShouldFail
	| stack prefix actualSentencesWithPrefix |

	prefix := 'ho la'.
	stack := OOStack new.
	
	stack push: 'holanda'.
	stack push: 'hola'.
	stack push: 'Smalltalk'.
	
	
	
	self
		should: [ actualSentencesWithPrefix:= SentenceFinderByPrefix new findSentencesWithPrefix: prefix in: stack. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix InvalidPrefix].
	

! !


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

!Base methodsFor: 'as yet unclassified' stamp: 'BB 4/27/2022 18:05:58'!
hasHolderUnderneath

	^false.! !

!Base methodsFor: 'as yet unclassified' stamp: 'LM 4/28/2022 12:35:26'!
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

!ElementHolder methodsFor: 'as yet unclassified' stamp: 'BB 4/27/2022 18:05:43'!
hasHolderUnderneath

	^true.! !

!ElementHolder methodsFor: 'as yet unclassified' stamp: 'BB 4/26/2022 23:51:27'!
holderOnBottomOfMe

	^holderOnBottom.! !

!ElementHolder methodsFor: 'as yet unclassified' stamp: 'LM 4/28/2022 15:45:43'!
initalizeWithElementOnTop: anElement andHolderOnBottom: aHolder

	elementOnTop:= anElement.
	holderOnBottom := aHolder.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElementHolder class' category: 'Stack-Exercise'!
ElementHolder class
	instanceVariableNames: ''!

!ElementHolder class methodsFor: 'as yet unclassified' stamp: 'LM 4/28/2022 15:49:57'!
withElementOnTop: anElement andHolderOnBottom: aHolder

	^self new initalizeWithElementOnTop: anElement andHolderOnBottom: aHolder.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'head size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'comparing' stamp: 'LM 4/28/2022 12:33:13'!
isEqualTo: aOOStack

| selfCurrentHolder otherCurrentHolder|
	
	
	selfCurrentHolder := self headElementHolder.
	otherCurrentHolder := aOOStack headElementHolder.
	
	(self size = aOOStack size) ifFalse: [^false].
	
	[selfCurrentHolder hasHolderUnderneath] whileTrue: [
		
		(selfCurrentHolder elementOnTopOfMe = otherCurrentHolder elementOnTopOfMe)
		ifFalse: 
			[^ false].
	
		selfCurrentHolder := selfCurrentHolder holderOnBottomOfMe.
		otherCurrentHolder  := otherCurrentHolder  holderOnBottomOfMe .
	].

	^true.! !


!OOStack methodsFor: 'as yet unclassified' stamp: 'LM 4/28/2022 15:47:12'!
findElementsWithPrefix: aPrefix 
	
	| currentHolder elementsThatBeginsWithPrefix |
	
	elementsThatBeginsWithPrefix := OrderedCollection new.
	
	currentHolder := self headElementHolder .
	
		[currentHolder hasHolderUnderneath] whileTrue: [
		
		
		(currentHolder elementOnTopOfMe beginsWith: aPrefix) 
		ifTrue: 
			[elementsThatBeginsWithPrefix add: currentHolder elementOnTopOfMe].
	
		currentHolder := currentHolder holderOnBottomOfMe.
	].

	^elementsThatBeginsWithPrefix.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'BB 4/27/2022 18:22:02'!
headElementHolder

	^head.! !

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

!OOStack methodsFor: 'as yet unclassified' stamp: 'LM 4/28/2022 15:48:37'!
push: anElement

	size:= size + 1.

	head:= ElementHolder withElementOnTop: anElement andHolderOnBottom: head.! !

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

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'LM 4/28/2022 14:58:49'!
PrefixIsNotValid: aPrefix
	
	^ (aPrefix includesSubString: ' ') or: [(aPrefix isEmpty)].! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'LM 4/28/2022 15:35:18'!
findSentencesWithPrefix: aPrefix in: aCollection 
	
	(self PrefixIsNotValid: aPrefix) ifTrue: [^self error: self class InvalidPrefix].
	
	^ aCollection findElementsWithPrefix: aPrefix.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'LM 4/27/2022 19:36:12'!
InvalidPrefix
	
	^ 'Prefix cant be empty and must not contain spaces'! !
