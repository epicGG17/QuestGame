extends CharacterBody3D

const PickItems: Dictionary = {
	"SWORD" : "res://game_items/sword.tscn",
}

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
@export var jump_impulse = 20

@onready var floor_timer: Timer = $FloorTimer
@onready var hand1Ref: Node3D = $Head/Hand1
#@onready var hand2Ref: Node3D = $Hand2

var target_velocity: Vector3 = Vector3.ZERO
var money: int = 0
var was_on_floor: bool = false
#ran into item
var itemRef1 = null
var itemRef2 = null
#has and item
var handItem = null
var hasItem = false


func _ready():
	floor_timer.connect("timeout", floorCheck)
	
	pass
	
	
func _physics_process(delta):
	var direction = Vector3.ZERO
	
	if is_on_floor():
		was_on_floor = true
		floor_timer.start()
	#interaction
	if Input.is_action_pressed("interact"):
		#pick up or drop items
		if(handItem == null and !hasItem):
			print("pick up item")
			pickUpItem()
		
			
	elif Input.is_action_pressed("interact") and handItem != null:
		if(handItem != null):
			print("drop item")
			dropItem()
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

func addItemRef(item: Node3D, hand: int):
	if hand == 1:
		itemRef1 = item
		if(itemRef1 == null):
			print("There no item to get pick up")
		else:
			print("item is ready to be pick up")
		return
		
	if hand == 2:
		itemRef1 = item
	
func floorCheck():
	was_on_floor = false
	
func pickUpItem():
	if handItem == null:
		
		if itemRef1 != null:
			print("You pick an item")
			handItem = itemRef1
			itemRef1 = null
			hasItem = true
			
			
			handItem.reparent(hand1Ref)
			handItem.set_global_position(hand1Ref.global_transform.origin)
			handItem.holdItem()
			
			
func dropItem():
	if(handItem != null):
		hasItem = false
		#handItem.reparent.call_deferred(handItem.get_original_parent())
		handItem.holdItem()
		handItem = null
		
		#handItem.set_global_poasition(self.global_transform.origin)
	
			
	
	
