extends Area3D

func _ready():
	connect("body_entered", body_in_shield)
	connect("body_exited", body_out_of_shield)

func _process(delta):
	rotate_y(delta)

func body_in_shield(body: Node3D):
	print(body.name, " is inside shield!")

func body_out_of_shield(body: Node3D):
	print(body.name, " has left the shield!")
