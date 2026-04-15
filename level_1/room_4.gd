extends Node3D

class CheckType:
	var color: Color
	var isCorrect: bool
	func _init(colorLocal: Color, isCorrectLocal: bool):
		color = colorLocal
		isCorrect = isCorrectLocal

@onready var puz1 = $puz1
@onready var puz2 = $puz2
@onready var puz3 = $puz3
@onready var colorList = {
	puz1.name: CheckType.new(Color(1, 0, 0, 1), false),  #red
	puz2.name: CheckType.new(Color(0, 0, 1, 1), false), #blue
	puz3.name: CheckType.new(Color(1, 1, 0, 1), false) #yellow
}


	

# Called when the node enters the scene tree for the first time.
func _ready():
	var inoutRef = $inOut
	inoutRef.putNewArea("res://level_1/room_3.tscn")
	SignalBus.connect("puzCheck", dropKey)
	#$puz1.changingColor(colorList[2])
	#$puz2.changingColor(colorList[7])
	#$puz3.changingColor(Color(1, 0.0784314, 0.576471, 1))
	
	
	
	pass # Replace with function body.
func dropKey(color : Color, puzName : String): 
	if not(puzName in colorList):
		return
	var checkType: CheckType = colorList[puzName]
	if color == checkType.color:
		print("You got the color right")
		checkType.isCorrect = true
	
	for thePuz in colorList:
		var puzCheck : CheckType = colorList[thePuz]
		if puzCheck.isCorrect == false:
			return
	print("You Solve the Puzz here a key, bitch")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
