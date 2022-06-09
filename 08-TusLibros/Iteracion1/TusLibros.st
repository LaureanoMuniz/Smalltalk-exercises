!classDefinition: #TusLibrosTest category: 'TusLibros'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'test' stamp: 'LM 6/5/2022 22:27:39'!
test1NewCartIsEmpty

	self assert: Cart new isEmpty.! !

!TusLibrosTest methodsFor: 'test' stamp: 'LM 6/5/2022 23:09:31'!
test2CartWithABookIsNotEmpty

	|cart catalog|
	
	catalog := OrderedCollection with: 'Libro1'.
	cart := Cart withCatalog: catalog.

	 cart addToCart: 'Libro1' quantity: 1.
	
	self assert: cart isNotEmpty.! !

!TusLibrosTest methodsFor: 'test' stamp: 'LM 6/5/2022 23:09:20'!
test3cannotAddBookIfNotInCatalog

	|cart catalog|
	
	catalog := OrderedCollection new.
	cart := Cart withCatalog: catalog.
	
	self 
		should: [cart addToCart: 'Libro1' quantity: 1. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: cart bookNotInCatalogDescription.
			self assert: cart isEmpty ]! !

!TusLibrosTest methodsFor: 'test' stamp: 'LM 6/5/2022 23:09:04'!
test4bookQuantityToAddMustBeGreaterThanZero

	|cart catalog|
	
	catalog := OrderedCollection new.
	cart := Cart withCatalog: catalog.
	
	self 
		should: [ cart addToCart: 'Libro1' quantity: 0. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: cart quantityToAddMustBeGreaterThanZero .
			self assert: cart isEmpty ]! !

!TusLibrosTest methodsFor: 'test' stamp: 'LM 6/5/2022 23:59:39'!
test5bookQuantityOfNotAddedBookShouldBeZero
	|cart catalog|
	
	catalog := OrderedCollection with: 'Libro1'.
	cart := Cart withCatalog: catalog.
	
	self assert: (cart quantityOf: 'Libro1') = 0. ! !

!TusLibrosTest methodsFor: 'test' stamp: 'LM 6/5/2022 23:28:56'!
test6bookQuantityShouldAccumulate
	|cart catalog|
	
	catalog := OrderedCollection with: 'Libro1'.
	cart := Cart withCatalog: catalog.
	
	cart addToCart: 'Libro1' quantity: 7. 
	cart addToCart: 'Libro1' quantity: 3.
	
	self assert: (cart quantityOf: 'Libro1') = 10. ! !

!TusLibrosTest methodsFor: 'test' stamp: 'LM 6/6/2022 00:03:53'!
test7listCartOfNewCartShouldBeEmpty
	|cart catalog|
	
	catalog := OrderedCollection with: 'Libro1'.
	cart := Cart withCatalog: catalog.

	
	self assert: (cart listCart isEmpty). ! !

!TusLibrosTest methodsFor: 'test' stamp: 'LM 6/6/2022 00:15:54'!
test8listCartWithMultipleBooks
	|cart catalog|
	
	catalog := OrderedCollection with: 'Libro1' with: 'Libro2' with: 'Libro3'.
	cart := Cart withCatalog: catalog.
	cart addToCart: 'Libro1' quantity: 2.
	cart addToCart: 'Libro2' quantity: 1.
	cart addToCart: 'Libro3' quantity: 7.
	self assert: (cart listCart = '|Libro2|1|Libro1|2|Libro3|7'). ! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'ISBNbooksAndQuantity catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'LM 6/5/2022 23:57:17'!
addToCart: aBook quantity: quantityToAdd

	self assertThatBookIsInCatalog: aBook andQuantityToAddIsGreaterThanZero: quantityToAdd.
	
	ISBNbooksAndQuantity add: aBook -> ((self quantityOfBook: aBook afterAdding: quantityToAdd)).
	! !

!Cart methodsFor: 'as yet unclassified' stamp: 'LM 6/5/2022 23:49:35'!
assertThatBookIsInCatalog: aBook andQuantityToAddIsGreaterThanZero: quantityToAdd

	(quantityToAdd < 1) ifTrue: [^self error: self quantityToAddMustBeGreaterThanZero.].
	(catalog includes: aBook) ifFalse: [^self error: self bookNotInCatalogDescription]! !

!Cart methodsFor: 'as yet unclassified' stamp: 'LM 6/5/2022 22:50:05'!
bookNotInCatalogDescription

	^ 'This book is not in the catalog'.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'LM 6/5/2022 23:51:20'!
initialize

	ISBNbooksAndQuantity := Dictionary new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'LM 6/5/2022 23:51:20'!
isEmpty
	^ ISBNbooksAndQuantity size = 0.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'LM 6/5/2022 23:42:19'!
isNotEmpty

	^ (self isEmpty) not.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'LM 6/6/2022 00:12:48'!
listCart

	|listCart|
	
	listCart := String new.
	ISBNbooksAndQuantity keysAndValuesDo: [:aKey :aValue | listCart := listCart, '|', aKey asString ,'|', aValue asString].
	
	^ listCart.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'LM 6/5/2022 23:51:20'!
quantityOf: aBook

	^ ISBNbooksAndQuantity at: aBook ifAbsent: 0.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'LM 6/5/2022 23:57:17'!
quantityOfBook: aBook afterAdding: quantityToAdd

	^ (ISBNbooksAndQuantity at: aBook ifAbsent: 0) + quantityToAdd! !

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
