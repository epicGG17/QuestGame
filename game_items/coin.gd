extends Area3D
const ROTATION_SPEED = PI * 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", moneyMaker)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	rotate_y(ROTATION_SPEED * delta)


func moneyMaker(body: Node3D):
	if !body.is_in_group("player"):
		return
	
	if body.has_method("addMoney"):
		body.addMoney()
		queue_free()
	else:
		printerr("you fuck up")
	
