extends Area3D

@export var float_speed: float = 4.0
@export var float_scale: float = 0.375

var add: float = 0.0
var ascended_position: Vector3 = Vector3.ZERO
var original_position: Vector3

func _ready():
	connect("body_entered", body_in_shield)
	connect("body_exited", body_out_of_shield)
	original_position = transform.origin

func _process(delta):
	add += delta
	rotate_y(delta)
	ascended_position.y = sin(add * float_speed) * float_scale
	transform.origin.y = (original_position + ascended_position).y
	

func body_in_shield(body: Node3D):
	print(body.name, " is inside shield!")

func body_out_of_shield(body: Node3D):
	print(body.name, " has left the shield!")
