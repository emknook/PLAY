extends CharacterBody3D

const JUMP_VELOCITY = 4.5
const LOOKAROUND_SPEED = 0.002
const MOVEMENT_SPEED_GROUND = 0.6
const MOVEMENT_SPEED_AIR = 0.11
const MOVEMENT_FRICTION_GROUND = 0.9
const MOVEMENT_FRICTION_AIR = 0.98
var rot_x = 0
var rot_y = 0
var _mouse_motion = Vector2()
var target_velocity = Vector3.ZERO
@onready var pov = $POV
@onready var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var raycast = $POV/Raycast
var colliding = false
var looking_at

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Keyboard movement.
	var movement_vec2 = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var movement = transform.basis * (Vector3(movement_vec2.x, 0, movement_vec2.y))

	if is_on_floor():
		movement *= MOVEMENT_SPEED_GROUND
	else:
		movement *= MOVEMENT_SPEED_AIR

	# Gravity.
	velocity.y -= gravity * delta

	velocity += Vector3(movement.x, 0, movement.z)
	# Apply horizontal friction.
	velocity.x *= MOVEMENT_FRICTION_GROUND if is_on_floor() else MOVEMENT_FRICTION_AIR
	velocity.z *= MOVEMENT_FRICTION_GROUND if is_on_floor() else MOVEMENT_FRICTION_AIR
	move_and_slide()

func _process(delta):	
	# Mouse movement.
	_mouse_motion.y = clamp(_mouse_motion.y, -1560, 1560)
	transform.basis = Basis.from_euler(Vector3(0, _mouse_motion.x * -0.001, 0))
	pov.transform.basis = Basis.from_euler(Vector3(_mouse_motion.y * -0.001, 0, 0))
	
	if raycast.is_colliding():
		colliding = true
	else:
		colliding = false
	
	if Input.is_action_just_pressed("shoot") and colliding:		
		var ray_position = raycast.get_collision_point()
		var thing = raycast.get_collider()
		thing.applyRule("BIG")

func _input(event):
#	when holding q => open menu selection for rules
#   up == BIG, left == GRAVITY, right == REVERSE, down == LIQUID
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			_mouse_motion += event.relative
	

	move_and_slide()
