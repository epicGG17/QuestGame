extends Area3D

@export var color: Color = Color8(255,255,255,255)
@export var colorChangeArr: Array[Color] = []
var colorChangeArrIdx = 0

var canChangeColor = false
@onready var meshInstance: MeshInstance3D = $block/MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", enterPuzzel)
	connect("body_exited", exitPuzzel)
	changingColor(color)
	
	meshInstance.mesh = meshInstance.mesh.duplicate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event: InputEvent):
	if event.is_action_pressed("interact") and canChangeColor:
		colorChangeArrIdx += 1
		if colorChangeArrIdx >= colorChangeArr.size():
			colorChangeArrIdx = 0
		changingColor(colorChangeArr[colorChangeArrIdx]) #orange
		SignalBus.emit_signal("puzCheck", getCurrect(), name)
		
		

func enterPuzzel(body: Node3D):
	if body.is_in_group("player"):
		canChangeColor = true
		print("Press e to change color")

func exitPuzzel(body: Node3D):
	if body.is_in_group("player"):
		canChangeColor = false
		print("Can't change color")

func changingColor(colors: Color):
	var material: StandardMaterial3D = meshInstance.mesh.surface_get_material(0).duplicate()
	material.albedo_color = colors
	meshInstance.mesh.surface_set_material(0, material)
	
func getCurrect() -> Color : 
	return colorChangeArr[colorChangeArrIdx]
