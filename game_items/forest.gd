extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", caveLevel)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func caveLevel(body: Node3D):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://level_1/room_6.tscn")



