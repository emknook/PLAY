extends Node3D
#@onready var floorTile = $Floor
@onready var timer = Timer.new()
@onready var black = $CenterContainer/Black

#const RANGE = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	add_child(timer)
	timer.one_shot = true
	black.visible
	var fader = get_tree().create_tween()
	fader.tween_property(black, "modulate:a", 0.0, 1)
	#timer.connect("timeout")
	#create_floor_grid()

#func create_floor_grid():
	#var world = floorTile.get_parent()
	#var origin = floorTile.global_transform.origin
	#
	#for x in range(-RANGE, RANGE):
		#for z in range(-RANGE, RANGE):
			#if x == 0 and z == 0:
				#continue
			#var new_floor = floorTile.duplicate()
			#var new_transform = floorTile.global_transform
			#var tile_size = floorTile.TILE_SIZE
			#new_transform.origin += Vector3(x * tile_size, 0, z * tile_size)
			#new_floor.global_transform = new_transform
			#world.add_child(new_floor)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Escape"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
