!classDefinition: #MarsRoverLoggerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverLoggerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/30/2022 20:15:27'!
test01

	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followPositionChangesOn: marsRover.
	
	marsRover process: ''.
	
	self assert: logger readStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/30/2022 20:19:07'!
test02

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followPositionChangesOn: marsRover.
	
	marsRover process: 'f'.
	
	logStream := logger readStream.
	self assert: '1@2' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/30/2022 20:27:10'!
test03

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followPositionChangesOn: marsRover.
	
	marsRover process: 'b'.
	
	logStream := logger readStream.
	self assert: '1@0' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/30/2022 20:30:55'!
test04

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	logger := MarsRoverLogger followPositionChangesOn: marsRover.
	
	marsRover process: 'fb'.
	
	logStream := logger readStream.
	self assert: '2@1' equals: logStream nextLine.
	self assert: '1@1' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/30/2022 20:42:10'!
test05

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followHeadingChangesOn: marsRover.
	
	marsRover process: 'r'.
	
	logStream := logger readStream.
	self assert: 'East' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'Blas 5/30/2022 21:14:32'!
test06

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followHeadingChangesOn: marsRover.
	
	marsRover process: 'l'.
	
	logStream := logger readStream.
	self assert: 'West' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'Blas 5/30/2022 21:40:38'!
test07

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followHeadingChangesOn: marsRover.
	
	marsRover process: 'll'.
	
	logStream := logger readStream.
	self assert: 'West' equals: logStream nextLine.
	self assert: 'South' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'Blas 5/30/2022 21:42:19'!
test08

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followHeadingChangesOn: marsRover.
	
	marsRover process: 'lr'.
	
	logStream := logger readStream.
	self assert: 'West' equals: logStream nextLine.
	self assert: 'North' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 18:42:58'!
test09

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followHeadingAndPositionChangesOn: marsRover.
	
	marsRover process: 'lf'.
	
	logStream := logger readStream.
	self assert: 'West' equals: logStream nextLine.
	self assert: '0@1' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 18:41:27'!
test10

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followPositionChangesOn: marsRover.
	
	marsRover process: 'lf'.
	
	logStream := logger readStream.
	self assert: '0@1' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 18:41:57'!
test11

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followHeadingChangesOn: marsRover.
	
	marsRover process: 'lf'.
	
	logStream := logger readStream.
	self assert: 'West' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'BB 6/2/2022 00:22:43'!
test12

	| marsRover logger otherLogger logStream otherLogStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followHeadingChangesOn: marsRover.
	otherLogger := MarsRoverLogger followHeadingChangesOn: marsRover.
	
	marsRover process: 'lf'.
	
	logStream := logger readStream.
	self assert: 'West' equals: logStream nextLine.
	self assert: logStream atEnd.

	otherLogStream := otherLogger readStream.
	self assert: 'West' equals: otherLogStream nextLine.
	self assert: otherLogStream atEnd.
! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRoverWindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 18:32:10'!
test01

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := MarsRoverWindow followPositionChangesOn: marsRover.
	
	marsRover process: ''.
	
	self assert: window show =  'Posición: -. Dirección: -' .
! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 18:32:26'!
test02

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := MarsRoverWindow followPositionChangesOn: marsRover.
	
	marsRover process: 'f'.
	self assert:  'Posición: 1@2. Dirección: -' equals: window show.

! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 18:32:46'!
test03

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := MarsRoverWindow followPositionChangesOn: marsRover.
	
	marsRover process: 'b'.
	self assert: 'Posición: 1@0. Dirección: -'equals: window show.


! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 18:32:59'!
test04

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := MarsRoverWindow followPositionChangesOn: marsRover.
	
	marsRover process: 'f'.
	self assert: 'Posición: 1@2. Dirección: -' equals: window show.
	marsRover process: 'b'.
	self assert: 'Posición: 1@1. Dirección: -' equals: window show.

! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 18:33:15'!
test05

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := MarsRoverWindow followHeadingChangesOn: marsRover.
	
	marsRover process: 'r'.
	self assert: 'Posición: -. Dirección: Apuntando al Este' equals: window show.

! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 18:34:00'!
test06

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := MarsRoverWindow followHeadingChangesOn: marsRover.
	
	marsRover process: 'l'.
	self assert: 'Posición: -. Dirección: Apuntando al Oeste'  equals: window show.
	
	
	
	

! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 18:39:31'!
test07

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := MarsRoverWindow followHeadingChangesOn: marsRover.
	
	marsRover process: 'l'.
	self assert: 'Posición: -. Dirección: Apuntando al Oeste'  equals: window show.
	
	marsRover process: 'l'.
	self assert: 'Posición: -. Dirección: Apuntando al Sur'  equals: window show.
	
	

! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 18:34:43'!
test08

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := MarsRoverWindow followPositionChangesOn: marsRover.
	
	marsRover process: 'f'.
	self assert: 'Posición: 1@2. Dirección: -'  equals: window show.
	
	marsRover process: 'l'.
	self assert: 'Posición: 1@2. Dirección: -'  equals: window show.
	
	

! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 18:42:58'!
test09

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := MarsRoverWindow followHeadingAndPositionChangesOn: marsRover.
	
	marsRover process: 'f'.
	self assert: 'Posición: 1@2. Dirección: -'  equals: window show.
	
	marsRover process: 'l'.
	self assert: 'Posición: 1@2. Dirección: Apuntando al Oeste' equals: window show.
	
	

! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 18:44:07'!
test10

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := MarsRoverWindow followHeadingAndPositionChangesOn: marsRover.
	
	marsRover process: 'f'.
	self assert: 'Posición: 1@2. Dirección: -'  equals: window show.
	
	marsRover process: 'l'.
	self assert: 'Posición: 1@2. Dirección: Apuntando al Oeste' equals: window show.
	

	
	
	

! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 18:55:03'!
test11

	| marsRover window logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := MarsRoverWindow followHeadingAndPositionChangesOn: marsRover.
	logger := MarsRoverLogger followHeadingAndPositionChangesOn: marsRover.
	
	marsRover process: 'f'.
	self assert: 'Posición: 1@2. Dirección: -'  equals: window show.
	
	marsRover process: 'l'.
	self assert: 'Posición: 1@2. Dirección: Apuntando al Oeste' equals: window show.
	
	marsRover process: 'rbfrr'.
	
	logStream := logger readStream.
	self assert: '1@2' equals: logStream nextLine.
	self assert: 'West' equals: logStream nextLine.
	self assert: 'North' equals: logStream nextLine.
	self assert: '1@1' equals: logStream nextLine.
	self assert: '1@2' equals: logStream nextLine.
	self assert: 'East' equals: logStream nextLine.
	self assert: 'South' equals: logStream nextLine.
	self assert: logStream atEnd.

	
	

! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head positionVisitors headingVisitors proxyPosition proxyHeading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'BB 6/2/2022 00:01:55'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	positionVisitors := OrderedCollection new.
	headingVisitors := OrderedCollection new.
	proxyPosition := ProxyPosition new.
	proxyHeading := ProxyHeading new.! !


!MarsRover methodsFor: 'heading' stamp: 'BB 6/2/2022 00:05:37'!
changeHeadAndLogNewHead: aHead
	
	head := aHead.
	proxyHeading headingChangedTo: aHead.! !

!MarsRover methodsFor: 'heading' stamp: 'Blas 5/30/2022 21:46:14'!
headEast
	
	self changeHeadAndLogNewHead: (MarsRoverHeadingEast for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'Blas 5/30/2022 21:46:42'!
headNorth
	
	self changeHeadAndLogNewHead: (MarsRoverHeadingNorth for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'Blas 5/30/2022 21:46:53'!
headSouth
	
	self changeHeadAndLogNewHead: (MarsRoverHeadingSouth for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'Blas 5/30/2022 21:47:00'!
headWest
	
	self changeHeadAndLogNewHead: (MarsRoverHeadingWest for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	head rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'BB 6/1/2022 23:49:18'!
addToPositionAndLogNewPosition: newPosition

	position := position + newPosition.
	proxyPosition positionChangedTo: position.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 5/30/2022 20:38:44'!
moveEast
	
	self addToPositionAndLogNewPosition: 1@0.
	! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 5/30/2022 20:38:44'!
moveNorth
	
	self addToPositionAndLogNewPosition: 0@1.
	! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 5/30/2022 20:38:44'!
moveSouth
	
	self addToPositionAndLogNewPosition: 0@-1.
	! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 5/30/2022 20:38:44'!
moveWest
	
	self addToPositionAndLogNewPosition: -1@0! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'as yet unclassified' stamp: 'BB 6/2/2022 00:03:42'!
followHeadingChangesWith: aHeadingVisitor 
	
	proxyHeading addHeadingVisitor: aHeadingVisitor.
	

	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'BB 6/1/2022 23:38:48'!
followPositionChangesWith: aPositionVisitor 

	proxyPosition addPositionVisitor: aPositionVisitor.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !


!MarsRoverHeading methodsFor: 'as yet unclassified' stamp: 'Blas 5/30/2022 21:04:58'!
accept: aVisitor

	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'as yet unclassified' stamp: 'HAW 5/30/2022 20:46:21'!
accept: aVisitor

	^aVisitor visitMarsRoverHeadingEast: self! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!MarsRoverHeadingNorth methodsFor: 'as yet unclassified' stamp: 'Blas 5/30/2022 21:42:41'!
accept: aVisitor

	^aVisitor visitMarsRoverHeadingNorth: self! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!MarsRoverHeadingSouth methodsFor: 'as yet unclassified' stamp: 'Blas 5/30/2022 21:28:43'!
accept: aVisitor

	^aVisitor visitMarsRoverHeadingSouth: self! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!MarsRoverHeadingWest methodsFor: 'as yet unclassified' stamp: 'Blas 5/30/2022 21:21:46'!
accept: aVisitor

	^aVisitor visitMarsRoverHeadingWest: self! !


!classDefinition: #MarsRoverVisitor category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!


!classDefinition: #MarsRoverLogger category: 'MarsRover-WithHeading'!
MarsRoverVisitor subclass: #MarsRoverLogger
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'BB 6/2/2022 00:08:04'!
followHeadingAndPositionChangesOn: aMarsRover 
	
	self followHeadingChangesOn: aMarsRover.
	self followPositionChangesOn: aMarsRover.! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'HAW 5/30/2022 20:43:13'!
followHeadingChangesOn: aMarsRover 
	
	aMarsRover followHeadingChangesWith: self! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'BB 6/1/2022 23:42:08'!
followPositionChangesOn: aMarsRover 
	
	aMarsRover followPositionChangesWith: self.! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'HAW 5/30/2022 20:46:00'!
headingChangedTo: aMarsRoverHeading
	
	aMarsRoverHeading accept: self! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'HAW 5/30/2022 20:25:00'!
initialize

	log  := WriteStream on: ''! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'HAW 5/30/2022 20:22:16'!
positionChangedTo: aPosition

	log print: aPosition; newLine! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'HAW 5/30/2022 20:23:26'!
readStream
	
	^ReadStream on: log contents ! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'Blas 5/30/2022 21:22:31'!
visitMarsRoverHeadingEast: aMarsRoverHeadingEast
	
	log nextPutAll: 'East'; newLine! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'Blas 5/30/2022 21:43:56'!
visitMarsRoverHeadingNorth: aMarsRoverHeadingNorth
	
	log nextPutAll: 'North'; newLine.! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'Blas 5/30/2022 21:36:55'!
visitMarsRoverHeadingSouth: aMarsRoverHeadingSouth
	
	log nextPutAll: 'South'; newLine.! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'Blas 5/30/2022 21:23:23'!
visitMarsRoverHeadingWest: aMarsRoverHeadingWest 
	
	log nextPutAll: 'West'; newLine.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverLogger class' category: 'MarsRover-WithHeading'!
MarsRoverLogger class
	instanceVariableNames: ''!

!MarsRoverLogger class methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 18:42:58'!
followHeadingAndPositionChangesOn: aMarsRover 
	
	^self new followHeadingAndPositionChangesOn: aMarsRover ! !

!MarsRoverLogger class methodsFor: 'as yet unclassified' stamp: 'HAW 5/30/2022 20:42:45'!
followHeadingChangesOn: aMarsRover 
	
	^self new followHeadingChangesOn: aMarsRover ! !

!MarsRoverLogger class methodsFor: 'as yet unclassified' stamp: 'HAW 5/30/2022 20:16:11'!
followPositionChangesOn: aMarsRover 
	
	^self new followPositionChangesOn: aMarsRover ! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-WithHeading'!
MarsRoverVisitor subclass: #MarsRoverWindow
	instanceVariableNames: 'lastPositionMessage lastHeadMessage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'BB 6/2/2022 00:08:24'!
followHeadingAndPositionChangesOn: aMarsRover 
	
	self followHeadingChangesOn: aMarsRover.
	self followPositionChangesOn: aMarsRover.! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 14:22:56'!
followHeadingChangesOn: aMarsRover 
	
	aMarsRover followHeadingChangesWith: self! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 14:22:56'!
followPositionChangesOn: aMarsRover 
	
	aMarsRover followPositionChangesWith: self! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 14:22:57'!
headingChangedTo: aMarsRoverHeading
	
	aMarsRoverHeading accept: self! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 18:29:39'!
initialize

	lastPositionMessage  := '-'.
	lastHeadMessage := '-'.! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 15:01:42'!
positionChangedTo: aPosition

	lastPositionMessage := aPosition asString.! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 18:31:48'!
show

	^ 'Posición: ', self showPosition ,'. Dirección: ', self showHeading.! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 14:38:13'!
showHeading

	^ lastHeadMessage.! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 14:46:13'!
showPosition

	^ lastPositionMessage.! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 14:38:13'!
visitMarsRoverHeadingEast: aMarsRoverHeadingEast
	
	lastHeadMessage := 'Apuntando al Este'.! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 14:38:13'!
visitMarsRoverHeadingNorth: aMarsRoverHeadingNorth
	
	lastHeadMessage := 'Apuntando al Norte'.! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 14:38:13'!
visitMarsRoverHeadingSouth: aMarsRoverHeadingSouth
	
	lastHeadMessage := 'Apuntando al Sur'.! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 14:38:13'!
visitMarsRoverHeadingWest: aMarsRoverHeadingWest 
	
	lastHeadMessage := 'Apuntando al Oeste'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverWindow class' category: 'MarsRover-WithHeading'!
MarsRoverWindow class
	instanceVariableNames: ''!

!MarsRoverWindow class methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 18:42:58'!
followHeadingAndPositionChangesOn: aMarsRover 
	
	^self new followHeadingAndPositionChangesOn: aMarsRover ! !

!MarsRoverWindow class methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 14:22:57'!
followHeadingChangesOn: aMarsRover 
	
	^self new followHeadingChangesOn: aMarsRover ! !

!MarsRoverWindow class methodsFor: 'as yet unclassified' stamp: 'LM 5/31/2022 14:22:57'!
followPositionChangesOn: aMarsRover 
	
	^self new followPositionChangesOn: aMarsRover ! !


!classDefinition: #ProxyHeading category: 'MarsRover-WithHeading'!
Object subclass: #ProxyHeading
	instanceVariableNames: 'headingVisitors'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!ProxyHeading methodsFor: 'add visitor' stamp: 'BB 6/2/2022 00:04:45'!
addHeadingVisitor: aHeadingVisitor 
	
	headingVisitors addLast: aHeadingVisitor.! !


!ProxyHeading methodsFor: 'change' stamp: 'BB 6/2/2022 00:06:26'!
headingChangedTo: aHeading
 
	headingVisitors do: [:aHeadingVisitor | aHeadingVisitor headingChangedTo: aHeading ].! !


!ProxyHeading methodsFor: 'initialization' stamp: 'BB 6/2/2022 00:02:26'!
initialize

	headingVisitors := OrderedCollection new.! !


!classDefinition: #ProxyPosition category: 'MarsRover-WithHeading'!
Object subclass: #ProxyPosition
	instanceVariableNames: 'positionVisitors'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!ProxyPosition methodsFor: 'add visitor' stamp: 'BB 6/1/2022 23:40:46'!
addPositionVisitor: aPositionVisitor

	positionVisitors addLast: aPositionVisitor.! !


!ProxyPosition methodsFor: 'change' stamp: 'BB 6/1/2022 23:46:52'!
positionChangedTo: aPosition

	positionVisitors do: [ :aPositionVisitor | aPositionVisitor positionChangedTo: aPosition].! !


!ProxyPosition methodsFor: 'initialization' stamp: 'BB 6/1/2022 23:40:46'!
initialize

	positionVisitors := OrderedCollection new.! !
