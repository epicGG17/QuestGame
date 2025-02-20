extends Area3D
const ROTATION_SPEED = PI * 0.5
var isHolding = false


# Called when the node enters the scene tree for the first time.
func _ready():
	print()
	connect("body_entered", swordEnter)
	connect("body_exited", swordExit)
	
	rotation_degrees.y = 90.0
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!isHolding):
		rotate_y(ROTATION_SPEED * delta)
		
func holdItem():
	isHolding = !isHolding
	if(isHolding):
		scale = Vector3(0.5, 0.5, 0.5)
		transform.origin = Vector3(0, 0.7, 0)
		
	else:
		scale = Vector3(1, 1, 1)
		transform.origin = Vector3.ZERO
		
		
func swordEnter(body: Node3D):
	if body.is_in_group("player") and !isHolding:
		body.addItemRef(self, 1)
		
func swordExit(body: Node3D):
	if body.is_in_group("player") and !isHolding:
		body.addItemRef(null, 1)
	



