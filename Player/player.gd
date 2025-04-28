extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const LOOKAROUND_SPEED = 0.002
var rot_x = 0
var rot_y = 0
@onready var pov = $POV

#func _init():
	#Input.MouseMode = "Captured"

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

func _input(event):
	if event is InputEventMouseMotion and event.button_mask & 1:
		# modify accumulated mouse rotation
		rot_x -= event.relative.x * LOOKAROUND_SPEED
		rot_y -= event.relative.y * LOOKAROUND_SPEED
		pov.transform.basis = Basis()
		pov.rotate_object_local(Vector3(0, 1, 0), rot_x) # first rotate in Y
		pov.rotate_object_local(Vector3(1, 0, 0), rot_y) # then rotate in X
	

	move_and_slide()
