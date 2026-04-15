extends Node3D

@onready var area3dRef: Area3D = $Area3D
var nextArea : String = ""

@export var currentLvlID : int = -1

@onready var playerPosRef : Node3D = $player_position
var playerRef: CharacterBody3D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	area3dRef.connect("body_entered", enterDiffArea)
	playerRef = get_tree().current_scene.get_node("Dude")
	if is_instance_valid(playerRef) && ChangeLvl.currentLvlID == currentLvlID:
		playerRef.global_transform.origin = playerPosRef.global_transform.origin
	pass # Replace with function body.

func putNewArea(newArea: String):
	self.nextArea = newArea

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func enterDiffArea(body: Node3D):
	
	if body.is_in_group("player"):
		print("You Enter transition area")
		if(nextArea == ""):
			print("Can't enter the next Area yet")
		else:
			print("Going to different area")
			ChangeLvl.currentLvlID = currentLvlID
			get_tree().call_deferred("change_scene_to_file", nextArea)
