extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var inoutRef = $inOut
	inoutRef.putNewArea("res://level_1/room_1.tscn")
	var inoutRef2 = $inOut2
	inoutRef2.putNewArea("res://level_1/room_3.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
