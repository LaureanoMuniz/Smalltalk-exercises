!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'test' stamp: 'AS 5/12/2022 20:41:58'!
test01RoverStaysAtOriginWhenRecievesEmptyStringHeadingSouth

	| marsRover |
	
	marsRover := MarsRover at: 0@0 heading: #South.
	
	self assert: ((marsRover process: '') isAt: 0@0 heading: #South)! !

!MarsRoverTest methodsFor: 'test' stamp: 'AS 5/12/2022 21:00:07'!
test02RoverMovesOnePositionForward

	| marsRover |
	
	marsRover := MarsRover at: 0@0 heading: #South.
	
	self assert: ((marsRover process: 'f') isAt: 0@-1 heading: #South)! !

!MarsRoverTest methodsFor: 'test' stamp: 'AS 5/12/2022 21:06:35'!
test03RoverMovesTwoPositionsForward

	| marsRover |
	
	marsRover := MarsRover at: 0@0 heading: #South.
	
	self assert: ((marsRover process: 'ff') isAt: 0@-2 heading: #South)! !

!MarsRoverTest methodsFor: 'test' stamp: 'AS 5/12/2022 21:07:40'!
test04RoverMovesTwoPositionsBackwards

	| marsRover |
	
	marsRover := MarsRover at: 0@0 heading: #South.
	
	self assert: ((marsRover process: 'bb') isAt: 0@2 heading: #South)! !

!MarsRoverTest methodsFor: 'test' stamp: 'AS 5/12/2022 21:11:39'!
test05RoverIsHeadingWestAfterRotatingRightWhenHeadingSouthAtCreation

	| marsRover |
	
	marsRover := MarsRover at: 0@0 heading: #South.
	
	self assert: ((marsRover process: 'r') isAt: 0@0 heading: #West)! !

!MarsRoverTest methodsFor: 'test' stamp: 'AS 5/12/2022 21:13:35'!
test06RoverIsHeadingNorthAfterRotatingRightTwoTimesWhenHeadingSouthAtCreation

	| marsRover |
	
	marsRover := MarsRover at: 0@0 heading: #South.
	
	self assert: ((marsRover process: 'r') isAt: 0@0 heading: #West)! !

!MarsRoverTest methodsFor: 'test' stamp: 'AS 5/12/2022 21:17:05'!
test07RoverIsHeadingSouthAfterRotatingRightTwoTimesWhenHeadingNorthAtCreation

	| marsRover |
	
	marsRover := MarsRover at: 0@0 heading: #North.
	
	self assert: ((marsRover process: 'rr') isAt: 0@0 heading: #South)! !

!MarsRoverTest methodsFor: 'test' stamp: 'AS 5/12/2022 21:52:57'!
test08RoverMovesOnePositionFowardAfterRotatingRightStartingNorth

	| marsRover |
	
	marsRover := MarsRover at: 0@0 heading: #North.
	
	self assert: ((marsRover process: 'rb') isAt: -1@0 heading: #East)! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'AS 5/12/2022 20:54:07'!
initializeMarsRoverAt: aPosition heading: aCardinalDirection
	
	position:= aPosition.
	
	orientation:= aCardinalDirection.
! !


!MarsRover methodsFor: 'instructions' stamp: 'AS 5/12/2022 22:03:03'!
positionAfterMovingBackwards


	(orientation = #West) ifTrue: [^ (position x + 1 @ position y)].
	(orientation = #South) ifTrue: [^(position x @ (position y+1))].
	(orientation = #North) ifTrue: [^(position x  @ (position y-1))].
	(orientation = #East) ifTrue: [^(position x-1  @ position y)].


 ! !

!MarsRover methodsFor: 'instructions' stamp: 'AS 5/12/2022 21:47:27'!
process: anInstruction
		
	anInstruction do: [ :char |
		(char = $b) ifTrue: [position := self positionAfterMovingBackwards].
		(char = $f) ifTrue: [position := position x @ (position y - 1)].
		(char = $r) ifTrue: [
			orientation := self orientationAfterRotatingRight.
			].
		].! !


!MarsRover methodsFor: 'position' stamp: 'AS 5/12/2022 21:00:17'!
isAt: aPosition heading: aCardinalDirection 

	^((aPosition = position) and: [aCardinalDirection = orientation]).! !

!MarsRover methodsFor: 'position' stamp: 'AS 5/12/2022 21:47:27'!
orientationAfterRotatingRight

	(orientation = #West) ifTrue: [^#North].
	(orientation = #South) ifTrue: [^#West].
	(orientation = #North) ifTrue: [^#East].
	(orientation = #East) ifTrue: [^#South].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'AS 5/12/2022 20:48:27'!
at: aPoint heading: aCardinalDirection
	^self new initializeMarsRoverAt: aPoint heading: aCardinalDirection ! !
