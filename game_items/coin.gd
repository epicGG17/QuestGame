extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", moneyMaker)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func moneyMaker(body: Node3D):
	if !body.is_in_group("player"):
		return
	
	if body.has_method("addMoney"):
		body.addMoney()
	else:
		printerr("you fuck up")
	
