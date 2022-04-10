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


!I class methodsFor: 'operations' stamp: 'LM 4/4/2022 20:40:58'!
* multiplicando
 ^ multiplicando.! !

!I class methodsFor: 'operations' stamp: 'ARM 3/31/2022 21:19:14'!
+ aNatural

	^aNatural next! !

!I class methodsFor: 'operations' stamp: 'LM 4/9/2022 13:43:48'!
- unNumero
	self error: self negativeNumbersNotSupportedErrorDescription.! !

!I class methodsFor: 'operations' stamp: 'LM 4/9/2022 13:47:22'!
/ unDivisor
	unDivisor = I ifTrue: [^ I].
	^ self error: self canNotDivideByBiggerNumberErrorDescription.
	! !


!I class methodsFor: 'private' stamp: 'LM 4/9/2022 13:46:33'!
canNotDivideByBiggerNumberErrorDescription

	^ 'No se puede dividir un número por otro mayor'.! !

!I class methodsFor: 'private' stamp: 'LM 4/9/2022 13:18:42'!
negativeNumbersNotSupportedErrorDescription

	^ 'El resultado de la operación debe pertenecer a los números naturales'.! !

!I class methodsFor: 'private' stamp: 'LM 4/9/2022 14:05:12'!
substractTo: unNumero
	^ unNumero previous.! !


!I class methodsFor: 'comparation' stamp: 'LM 4/9/2022 14:30:33'!
< unNumero
	unNumero = I ifTrue: [^false].
	^true.! !

!I class methodsFor: 'comparation' stamp: 'LM 4/9/2022 13:26:07'!
>= unNumero
	^ (self < unNumero) not.! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'LM 4/9/2022 14:36:05'!
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

!II class methodsFor: 'operations' stamp: 'LM 4/4/2022 20:40:27'!
* multiplicando
	^ multiplicando + (self previous * multiplicando).! !

!II class methodsFor: 'operations' stamp: 'ARM 3/31/2022 21:27:43'!
+ unNatural

	^previous + unNatural next! !

!II class methodsFor: 'operations' stamp: 'LM 4/4/2022 20:25:57'!
- unNatural

	^ unNatural substractTo: self.! !

!II class methodsFor: 'operations' stamp: 'LM 4/9/2022 14:34:52'!
/ Divisor
	(self < Divisor ) ifTrue: [^self error: self canNotDivideByBiggerNumberErrorDescription].
	(self = Divisor) ifTrue: [^ I].
	((self - Divisor) >= Divisor) ifTrue: [^ I + ((self - Divisor ) / Divisor).].
	(self - Divisor < Divisor) ifTrue: [^ I].! !


!II class methodsFor: 'next & previous' stamp: 'LM 4/9/2022 13:53:26'!
nameOfNext
	self ifNumberEnds: 'III' value: [^ self reemplazarUltimaParteDelNumero: 'III' con: 'IV' ].
	self ifNumberEnds: 'IV' value: [^ self reemplazarUltimaParteDelNumero: 'IV' con: 'V' ].
	self ifNumberEnds: 'VIII' value: [^ self reemplazarUltimaParteDelNumero: 'VIII' con: 'IX' ].
 	self ifNumberEnds: 'IX' value: [^ self reemplazarUltimaParteDelNumero: 'IX' con: 'X' ].
	self ifNumberEnds: 'XXXIX' value: [^ self reemplazarUltimaParteDelNumero: 'XXXIX' con: 'XL' ].
	self ifNumberEnds: 'XLIX' value: [^ self reemplazarUltimaParteDelNumero: 'XLIX' con: 'L' ].
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

!II class methodsFor: 'next & previous' stamp: 'ARM 3/31/2022 21:20:55'!
previous: unNatural 
	
	previous _ unNatural! !


!II class methodsFor: 'remove' stamp: 'LM 4/9/2022 13:26:39'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next _ nil.
	]! !


!II class methodsFor: 'comparation' stamp: 'LM 4/9/2022 14:30:07'!
< unNumero
	(unNumero = I) ifTrue: [^ false.].
	^ (self previous) < (unNumero  previous).! !

!II class methodsFor: 'comparation' stamp: 'LM 4/9/2022 14:28:21'!
>= unNumero
	^ (self < unNumero)not.! !


!II class methodsFor: 'private' stamp: 'LM 4/9/2022 13:18:04'!
canNotDivideByBiggerNumberErrorDescription

	^ 'No se puede dividir un número por otro mayor'.! !

!II class methodsFor: 'private' stamp: 'LM 4/9/2022 13:33:30'!
ifNumberEnds: sufix value: aBlockClosure 
	(self name endsWith: sufix) ifTrue: aBlockClosure .! !

!II class methodsFor: 'private' stamp: 'LM 4/9/2022 13:39:45'!
reemplazarUltimaParteDelNumero: ultimaParteDelNumero con: numeroDeReemplazo

	^(self name withoutSuffix: ultimaParteDelNumero), numeroDeReemplazo.! !

!II class methodsFor: 'private' stamp: 'LM 4/4/2022 20:31:36'!
substractTo: minuendo
	^ minuendo previous - self previous. ! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'LM 4/9/2022 14:36:05'!
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

!III class methodsFor: '--** private fileout/in **--' stamp: 'LM 4/9/2022 14:36:05'!
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

!IV class methodsFor: '--** private fileout/in **--' stamp: 'LM 4/9/2022 14:36:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IV initializeAfterFileIn!