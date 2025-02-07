extends CharacterBody3D


# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
@export var jump_impulse = 20

@onready var floor_timer: Timer = $FloorTimer

var target_velocity: Vector3 = Vector3.ZERO
var money: int = 0
var was_on_floor: bool = false

func _ready():
	floor_timer.connect("timeout", floorCheck)
	pass
	
	
func _physics_process(delta):
	var direction = Vector3.ZERO
	
	if is_on_floor():
		was_on_floor = true
		floor_timer.start()
	
	# Jumping.
	if was_on_floor and Input.is_action_just_pressed("jump"):
		target_velocity.y = jump_impulse
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.z += 1
	if Input.is_action_pressed("move_up"):
		direction.z -= 1

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Head.basis = Basis.looking_at(direction)

	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	# Moving the Character
	velocity = target_velocity
	move_and_slide()
	
func addMoney():
	money += 1
	print("you just made money: ", money)
	
func floorCheck():
	was_on_floor = false
