!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'test' stamp: 'lm 5/15/2022 20:31:51'!
test01RoverStaysAtOriginWhenRecievesEmptyStringHeadingSouth

	| marsRover |
	
	marsRover := MarsRover at: 0@0 heading: South.
	
	self assert: ((marsRover process: '') isAt: 0@0 heading: South)! !

!MarsRoverTest methodsFor: 'test' stamp: 'lm 5/15/2022 20:33:52'!
test02RoverMovesOnePositionForward

	| marsRover |
	
	marsRover := MarsRover at: 0@0 heading: South.
	
	self assert: ((marsRover process: 'f') isAt: 0@-1 heading: South)! !

!MarsRoverTest methodsFor: 'test' stamp: 'lm 5/15/2022 20:40:27'!
test03RoverMovesTwoPositionsForward

	| marsRover |
	
	marsRover := MarsRover at: 0@0 heading: South.
	
	self assert: ((marsRover process: 'ff') isAt: 0@-2 heading: South)! !

!MarsRoverTest methodsFor: 'test' stamp: 'lm 5/15/2022 20:40:36'!
test04RoverMovesTwoPositionsBackwards

	| marsRover |
	
	marsRover := MarsRover at: 0@0 heading: South.
	
	self assert: ((marsRover process: 'bb') isAt: 0@2 heading: South)! !

!MarsRoverTest methodsFor: 'test' stamp: 'lm 5/15/2022 20:40:43'!
test05RoverIsHeadingWestAfterRotatingRightStartingSouth

	| marsRover |
	
	marsRover := MarsRover at: 0@0 heading: South.
	
	self assert: ((marsRover process: 'r') isAt: 0@0 heading: West)! !

!MarsRoverTest methodsFor: 'test' stamp: 'lm 5/15/2022 20:40:49'!
test06RoverIsHeadingNorthAfterRotatingRightTwoTimesStartingSouth

	| marsRover |
	
	marsRover := MarsRover at: 0@0 heading: South.
	
	self assert: ((marsRover process: 'rr') isAt: 0@0 heading: North)! !

!MarsRoverTest methodsFor: 'test' stamp: 'lm 5/15/2022 20:40:58'!
test07RoverIsHeadingSouthAfterRotatingRightTwoTimesStartingNorth

	| marsRover |
	
	marsRover := MarsRover at: 0@0 heading: North.
	
	self assert: ((marsRover process: 'rr') isAt: 0@0 heading: South)! !

!MarsRoverTest methodsFor: 'test' stamp: 'lm 5/15/2022 20:41:04'!
test08RoverMovesOnePositionBackwardsAfterRotatingRightStartingNorth

	| marsRover |
	
	marsRover := MarsRover at: 0@0 heading: North.
	
	self assert: ((marsRover process: 'rb') isAt: -1@0 heading: East)! !

!MarsRoverTest methodsFor: 'test' stamp: 'lm 5/15/2022 20:41:11'!
test09RoverMovesOnePositionFowardAfterRotatingRightStartingWest

	| marsRover |
	
	marsRover := MarsRover at: 0@0 heading: West.
	
	self assert: ((marsRover process: 'rf') isAt: 0@1 heading: North)! !

!MarsRoverTest methodsFor: 'test' stamp: 'lm 5/15/2022 20:41:18'!
test10RoverMovesOnePositionFowardAfterRotatingLeftStartingWest

	| marsRover |
	
	marsRover := MarsRover at: 0@0 heading: West.
	
	self assert: ((marsRover process: 'lf') isAt: 0@-1 heading: South)! !

!MarsRoverTest methodsFor: 'test' stamp: 'lm 5/15/2022 20:41:24'!
test11RoverReturnsToStartingPositionAfterTravellingMovingBackwards
	| marsRover |
	
	marsRover := MarsRover at: 0@0 heading: North.
	
	self assert: ((marsRover process: 'bbbrbbbrbbbrbbb') isAt: 0@0 heading: West)! !

!MarsRoverTest methodsFor: 'test' stamp: 'lm 5/15/2022 20:50:55'!
test12RoverReturnsToStartingPositionAfterTravellingMovingFoward

	| marsRover |
	
	marsRover := MarsRover at: 0@0 heading: North.
	
	self assert: ((marsRover process: 'fffrfffrfffrfff') isAt: 0@0 heading: West)! !

!MarsRoverTest methodsFor: 'test' stamp: 'lm 5/15/2022 20:51:00'!
test13RoverTravelsCorrectlyUsingAllInstructions

	| marsRover |
	
	marsRover := MarsRover at: 0@0 heading: North.
	
	self assert: ((marsRover process: 'flbbbrrff') isAt: 5@1 heading: East)! !

!MarsRoverTest methodsFor: 'test' stamp: 'lm 5/15/2022 20:51:06'!
test14RoverStopsProcessingMessagesAfterBadInstruction

	| marsRover |
	
	marsRover := MarsRover at: 0@0 heading: North.
	
	self assert: ((marsRover process: 'fqklbbbrrff') isAt: 0@1 heading: North)! !

!MarsRoverTest methodsFor: 'test' stamp: 'lm 5/15/2022 21:38:54'!
test15RoverIsHeadingSouthAfterRotatingLeftFourTimes

	| marsRover |
	
	marsRover := MarsRover at: 0@0 heading: South.
	
	self assert: ((marsRover process: 'llll') isAt: 0@0 heading: South)! !


!classDefinition: #CardinalDirection category: 'MarsRover'!
Object subclass: #CardinalDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalDirection class' category: 'MarsRover'!
CardinalDirection class
	instanceVariableNames: ''!

!CardinalDirection class methodsFor: 'orientation' stamp: 'lm 5/15/2022 20:39:18'!
cardinalDirectionToTheLeft

	^ self subclassResponsibility.! !

!CardinalDirection class methodsFor: 'orientation' stamp: 'lm 5/15/2022 20:39:27'!
cardinalDirectionToTheRight

	^ self subclassResponsibility.! !


!CardinalDirection class methodsFor: 'position' stamp: 'lm 5/15/2022 20:48:35'!
onePositionBackwards: position

	^ self subclassResponsibility.! !

!CardinalDirection class methodsFor: 'position' stamp: 'lm 5/15/2022 20:48:58'!
onePositionForward: position

	^ self subclassResponsibility.! !


!classDefinition: #East category: 'MarsRover'!
CardinalDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: 'MarsRover'!
East class
	instanceVariableNames: ''!

!East class methodsFor: 'orientation' stamp: 'lm 5/15/2022 20:50:03'!
cardinalDirectionToTheLeft

	^ North.! !

!East class methodsFor: 'orientation' stamp: 'lm 5/15/2022 20:50:07'!
cardinalDirectionToTheRight

	^ South.! !


!East class methodsFor: 'position' stamp: 'lm 5/15/2022 20:48:35'!
onePositionBackwards: position

	^ (position x - 1 @ position y).! !

!East class methodsFor: 'position' stamp: 'lm 5/15/2022 20:48:58'!
onePositionForward: position

	^ (position x + 1 @ position y).! !


!classDefinition: #North category: 'MarsRover'!
CardinalDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: 'MarsRover'!
North class
	instanceVariableNames: ''!

!North class methodsFor: 'orientation' stamp: 'lm 5/15/2022 20:50:14'!
cardinalDirectionToTheLeft

	^ West.! !

!North class methodsFor: 'orientation' stamp: 'lm 5/15/2022 20:50:17'!
cardinalDirectionToTheRight

	^ East.! !


!North class methodsFor: 'position' stamp: 'lm 5/15/2022 20:48:35'!
onePositionBackwards: position

	^ (position x @ (position y - 1)).

! !

!North class methodsFor: 'position' stamp: 'lm 5/15/2022 20:48:58'!
onePositionForward: position

	^ (position x @ (position y + 1)).

! !


!classDefinition: #South category: 'MarsRover'!
CardinalDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: 'MarsRover'!
South class
	instanceVariableNames: ''!

!South class methodsFor: 'orientation' stamp: 'lm 5/15/2022 20:33:13'!
cardinalDirectionToTheLeft

	^ East.! !

!South class methodsFor: 'orientation' stamp: 'lm 5/15/2022 20:33:21'!
cardinalDirectionToTheRight

	^ West.! !


!South class methodsFor: 'position' stamp: 'lm 5/15/2022 20:48:35'!
onePositionBackwards: position

	^ (position x @ (position y + 1)).! !

!South class methodsFor: 'position' stamp: 'lm 5/15/2022 20:48:58'!
onePositionForward: position

	^ (position x @ (position y - 1)).! !


!classDefinition: #West category: 'MarsRover'!
CardinalDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: 'MarsRover'!
West class
	instanceVariableNames: ''!

!West class methodsFor: 'orientation' stamp: 'lm 5/15/2022 20:50:28'!
cardinalDirectionToTheLeft
	
	^ South.! !

!West class methodsFor: 'orientation' stamp: 'lm 5/15/2022 20:50:32'!
cardinalDirectionToTheRight

	^ North.! !


!West class methodsFor: 'position' stamp: 'lm 5/15/2022 20:48:35'!
onePositionBackwards: position

	^ (position x + 1 @ position y).! !

!West class methodsFor: 'position' stamp: 'lm 5/15/2022 20:48:58'!
onePositionForward: position

	^ (position x - 1 @ position y).! !


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


!MarsRover methodsFor: 'instructions' stamp: 'lm 5/15/2022 21:25:35'!
moveOnePositionBackwards

		position := orientation onePositionBackwards: position.
		
		
	
		
		
	! !

!MarsRover methodsFor: 'instructions' stamp: 'lm 5/15/2022 21:26:18'!
moveOnePositionForward

		position := orientation onePositionForward: position.
		
	
		
		
	! !

!MarsRover methodsFor: 'instructions' stamp: 'lm 5/15/2022 21:28:11'!
process: aSequenceOfInstructions
		
	aSequenceOfInstructions do: [ :instruction | 
		
		(MarsRoverInstruction isInstructionValid: instruction) ifFalse: [^self].
		
		(MarsRoverInstruction with: instruction) runInstructionInMarsRover: self.
	
	]
		
	
		
		
	! !

!MarsRover methodsFor: 'instructions' stamp: 'lm 5/15/2022 21:27:11'!
turnToTheLeft

	orientation := orientation cardinalDirectionToTheLeft.
		
	
		
	
		
		
	! !

!MarsRover methodsFor: 'instructions' stamp: 'lm 5/15/2022 21:27:23'!
turnToTheRight

	orientation := orientation cardinalDirectionToTheRight.
		
	
		
	
		
		
	! !


!MarsRover methodsFor: 'position' stamp: 'LM 5/15/2022 13:28:13'!
isAt: aPosition heading: aCardinalDirection 

	^((aPosition = position) and: [aCardinalDirection = orientation]).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'AS 5/12/2022 20:48:27'!
at: aPoint heading: aCardinalDirection
	^self new initializeMarsRoverAt: aPoint heading: aCardinalDirection ! !


!classDefinition: #MarsRoverInstruction category: 'MarsRover'!
Object subclass: #MarsRoverInstruction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverInstruction class' category: 'MarsRover'!
MarsRoverInstruction class
	instanceVariableNames: ''!

!MarsRoverInstruction class methodsFor: 'execution' stamp: 'lm 5/15/2022 21:46:13'!
runInstructionInMarsRover: aMarsRover
	
	^self subclassResponsibility.! !


!MarsRoverInstruction class methodsFor: 'class initialization' stamp: 'lm 5/15/2022 21:43:31'!
with: anInstruction 
	^ (self subclasses detect: [:anInstructionClass | anInstructionClass canHandle: anInstruction]).! !


!MarsRoverInstruction class methodsFor: 'validation' stamp: 'lm 5/15/2022 21:17:04'!
isInstructionValid: aInstruction 
	
	|ValidInstructions|
	
	ValidInstructions := #( $r $l $f $b).
	
	^ ValidInstructions includes: aInstruction.! !


!classDefinition: #Backwards category: 'MarsRover'!
MarsRoverInstruction subclass: #Backwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Backwards class' category: 'MarsRover'!
Backwards class
	instanceVariableNames: ''!

!Backwards class methodsFor: 'execution' stamp: 'lm 5/15/2022 21:28:35'!
runInstructionInMarsRover: aMarsRover
	
	aMarsRover moveOnePositionBackwards.! !


!Backwards class methodsFor: 'initialization' stamp: 'lm 5/15/2022 21:11:32'!
canHandle: anInstruction

	^ anInstruction  = $b.! !


!classDefinition: #Forward category: 'MarsRover'!
MarsRoverInstruction subclass: #Forward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Forward class' category: 'MarsRover'!
Forward class
	instanceVariableNames: ''!

!Forward class methodsFor: 'execution' stamp: 'lm 5/15/2022 21:29:02'!
runInstructionInMarsRover: aMarsRover
	
	aMarsRover moveOnePositionForward.! !


!Forward class methodsFor: 'initialization' stamp: 'lm 5/15/2022 21:11:40'!
canHandle: anInstruction

	^ anInstruction  = $f.! !


!classDefinition: #Left category: 'MarsRover'!
MarsRoverInstruction subclass: #Left
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Left class' category: 'MarsRover'!
Left class
	instanceVariableNames: ''!

!Left class methodsFor: 'execution' stamp: 'lm 5/15/2022 21:29:16'!
runInstructionInMarsRover: aMarsRover
	
	aMarsRover turnToTheLeft.! !


!Left class methodsFor: 'initialization' stamp: 'lm 5/15/2022 21:11:47'!
canHandle: anInstruction

	^ anInstruction  = $l.! !


!classDefinition: #Right category: 'MarsRover'!
MarsRoverInstruction subclass: #Right
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Right class' category: 'MarsRover'!
Right class
	instanceVariableNames: ''!

!Right class methodsFor: 'execution' stamp: 'lm 5/15/2022 21:29:27'!
runInstructionInMarsRover: aMarsRover
	
	aMarsRover turnToTheRight.! !


!Right class methodsFor: 'initialization' stamp: 'lm 5/15/2022 21:35:10'!
canHandle: anInstruction

	^ anInstruction = $r.! !
