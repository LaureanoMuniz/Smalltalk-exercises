!classDefinition: #I category: 'Numeros-Naturales-Ejemplares'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales-Ejemplares'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros-Naturales-Ejemplares'!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'next' stamp: 'LM 4/9/2022 13:57:14'!
next

	^II.! !


!I class methodsFor: 'operations' stamp: 'BB 4/10/2022 21:37:12'!
* multiplicand
 ^ multiplicand.! !

!I class methodsFor: 'operations' stamp: 'ARM 3/31/2022 21:19:14'!
+ aNatural

	^aNatural next! !

!I class methodsFor: 'operations' stamp: 'BB 4/10/2022 21:37:30'!
- aNatural
	self error: self negativeNumbersNotSupportedErrorDescription.! !

!I class methodsFor: 'operations' stamp: 'BB 4/10/2022 21:38:50'!
/ aDivisor
	aDivisor = I ifTrue: [^ I].
	^ self error: self canNotDivideByBiggerNumberErrorDescription.
	! !


!I class methodsFor: 'private' stamp: 'BB 4/10/2022 21:40:02'!
canNotDivideByBiggerNumberErrorDescription

	^ 'Cannot divide by a bigger number.'.! !

!I class methodsFor: 'private' stamp: 'BB 4/10/2022 21:39:57'!
negativeNumbersNotSupportedErrorDescription

	^ 'The result of this operation does not belong to the natural numbers.'.! !

!I class methodsFor: 'private' stamp: 'BB 4/10/2022 21:40:10'!
substractTo: aNatural
	^ aNatural previous.! !


!I class methodsFor: 'comparation' stamp: 'BB 4/10/2022 21:40:46'!
< aNatural
	aNatural = I ifTrue: [^false].
	^true.! !

!I class methodsFor: 'comparation' stamp: 'BB 4/10/2022 21:40:52'!
>= aNatural
	^ (self < aNatural) not.! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'BB 4/10/2022 21:56:39'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.! !


!classDefinition: #II category: 'Numeros-Naturales-Ejemplares'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales-Ejemplares'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros-Naturales-Ejemplares'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'operations' stamp: 'BB 4/10/2022 21:41:11'!
* multiplicand
	^ multiplicand + (self previous * multiplicand).! !

!II class methodsFor: 'operations' stamp: 'BB 4/10/2022 21:41:27'!
+ aNatural

	^previous + aNatural next! !

!II class methodsFor: 'operations' stamp: 'BB 4/10/2022 21:41:36'!
- aNatural

	^ aNatural substractTo: self.! !

!II class methodsFor: 'operations' stamp: 'LM 4/9/2022 14:34:52'!
/ Divisor
	(self < Divisor ) ifTrue: [^self error: self canNotDivideByBiggerNumberErrorDescription].
	(self = Divisor) ifTrue: [^ I].
	((self - Divisor) >= Divisor) ifTrue: [^ I + ((self - Divisor ) / Divisor).].
	(self - Divisor < Divisor) ifTrue: [^ I].! !


!II class methodsFor: 'next & previous' stamp: 'BB 4/10/2022 21:53:09'!
nameOfNext
	self ifNumberEnds: 'III' value: [^ self replaceLastPartOfNumber: 'III' with: 'IV' ].
	self ifNumberEnds: 'IV' value: [^ self replaceLastPartOfNumber: 'IV' with: 'V' ].
	self ifNumberEnds: 'VIII' value: [^ self replaceLastPartOfNumber: 'VIII' with: 'IX' ].
 	self ifNumberEnds: 'IX' value: [^ self replaceLastPartOfNumber: 'IX' with: 'X' ].
	self ifNumberEnds: 'XXXIX' value: [^ self replaceLastPartOfNumber: 'XXXIX' with: 'XL' ].
	self ifNumberEnds: 'XLIX' value: [^ self replaceLastPartOfNumber: 'XLIX' with: 'L' ].
	self ifNumberEnds: 'LXXXIX' value: [^ self replaceLastPartOfNumber: 'LXXXIX' with: 'XC' ].
	self ifNumberEnds: 'XCIX' value: [^ self replaceLastPartOfNumber: 'XCIX' with: 'C' ].
	self ifNumberEnds: 'CCCXCIX' value: [^ self replaceLastPartOfNumber: 'CCCXCIX' with: 'CD' ].
	self ifNumberEnds: 'CDXCIX' value: [^ self replaceLastPartOfNumber: 'CDXCIX' with: 'D' ].
	self ifNumberEnds: 'DCCCXCIX' value: [^ self replaceLastPartOfNumber: 'DCCCXCIX' with: 'CM' ].
	self ifNumberEnds: 'CMXCIX' value: [^ self replaceLastPartOfNumber: 'CMXCIX' with: 'M' ].
	^ self name , 'I'.! !

!II class methodsFor: 'next & previous' stamp: 'LM 4/4/2022 20:52:28'!
next
	next ifNotNil:[^next].
	next _ II createChildNamed: (self nameOfNext).
	next previous: self.
	^next! !

!II class methodsFor: 'next & previous' stamp: 'ARM 3/31/2022 21:26:45'!
previous

	^previous! !

!II class methodsFor: 'next & previous' stamp: 'BB 4/10/2022 21:42:04'!
previous: aNatural 
	
	previous _ aNatural! !


!II class methodsFor: 'remove' stamp: 'LM 4/9/2022 13:26:39'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next _ nil.
	]! !


!II class methodsFor: 'comparation' stamp: 'BB 4/10/2022 21:42:19'!
< aNatural
	(aNatural = I) ifTrue: [^ false.].
	^ (self previous) < (aNatural  previous).! !

!II class methodsFor: 'comparation' stamp: 'BB 4/10/2022 21:42:32'!
>= aNatural
	^ (self < aNatural)not.! !


!II class methodsFor: 'private' stamp: 'BB 4/10/2022 21:42:46'!
canNotDivideByBiggerNumberErrorDescription

	^ 'Cannot divide by a bigger number.'.! !

!II class methodsFor: 'private' stamp: 'LM 4/9/2022 13:33:30'!
ifNumberEnds: sufix value: aBlockClosure 
	(self name endsWith: sufix) ifTrue: aBlockClosure .! !

!II class methodsFor: 'private' stamp: 'BB 4/10/2022 21:44:54'!
replaceLastPartOfNumber: lastPartOfNumber with: replacementNumber

	^(self name withoutSuffix: lastPartOfNumber), replacementNumber.! !

!II class methodsFor: 'private' stamp: 'BB 4/10/2022 21:43:55'!
substractTo: minuend
	^ minuend previous - self previous. ! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'BB 4/10/2022 21:56:39'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Numeros-Naturales-Ejemplares'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales-Ejemplares'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros-Naturales-Ejemplares'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'BB 4/10/2022 21:56:40'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IV.
	previous := II.! !


!classDefinition: #IV category: 'Numeros-Naturales-Ejemplares'!
II subclass: #IV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales-Ejemplares'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IV class' category: 'Numeros-Naturales-Ejemplares'!
IV class
	instanceVariableNames: ''!

!IV class methodsFor: '--** private fileout/in **--' stamp: 'BB 4/10/2022 21:56:40'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := V.
	previous := III.! !


!classDefinition: #V category: 'Numeros-Naturales-Ejemplares'!
II subclass: #V
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales-Ejemplares'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'V class' category: 'Numeros-Naturales-Ejemplares'!
V class
	instanceVariableNames: ''!

!V class methodsFor: '--** private fileout/in **--' stamp: 'BB 4/10/2022 21:56:40'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IV.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IV initializeAfterFileIn!
V initializeAfterFileIn!