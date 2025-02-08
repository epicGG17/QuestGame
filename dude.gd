extends CharacterBody3D


# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
@export var jump_impulse = 20
@export var rotate_acceleration: float = 2.0

@onready var floor_timer: Timer = $FloorTimer
@onready var camera_pivot: Node3D = $CameraPivot
@onready var head_ref: Node3D = $Head

var target_velocity: Vector3 = Vector3.ZERO
var money: int = 0
var was_on_floor: bool = false

func _ready():
	floor_timer.connect("timeout", floorCheck)
	pass

func _process(delta):
	if Input.is_action_pressed("rotate_camera_left"):
		camera_pivot.rotate_y(delta * rotate_acceleration)
	if Input.is_action_pressed("rotate_camera_right"):
		camera_pivot.rotate_y(-delta * rotate_acceleration)
	
func _physics_process(delta):
	var direction = Vector3.ZERO
	
	if is_on_floor():
		was_on_floor = true
		floor_timer.start()
	
	# Jumping.
	if was_on_floor and Input.is_action_just_pressed("jump"):
		target_velocity.y = jump_impulse
	if Input.is_action_pressed("move_right"):
		direction += camera_pivot.global_basis.x
	if Input.is_action_pressed("move_left"):
		direction -= camera_pivot.global_basis.x
	if Input.is_action_pressed("move_down"):
		direction += camera_pivot.global_basis.z
	if Input.is_action_pressed("move_up"):
		direction -= camera_pivot.global_basis.z

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		head_ref.basis = Basis.looking_at(direction)

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
