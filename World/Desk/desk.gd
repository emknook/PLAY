extends Node3D
@onready var camera_3d = $Camera3D
@onready var subtitles = $CanvasLayer/Subtitles
@onready var screen = $CanvasLayer/Screen
@onready var game = $CanvasLayer/Screen/Game
@onready var black = $CanvasLayer/Screen/Black
@onready var text_file = $CanvasLayer/Screen/Text_file

var interacted = false
var in_screen = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen.visible = false
	text_file.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	subtitles.show_instruction("Press E: interact")
	black.modulate.a = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("Escape"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if Input.is_action_just_pressed("interact") and not interacted:
		var zoomTween = get_tree().create_tween()
		zoomTween.tween_property(camera_3d, "fov", 15, 1.25)
		subtitles.clear()
		interacted = true
		var timer = Timer.new()
		add_child(timer)
		timer.one_shot = true;
		timer.connect("timeout", show_screen)
		timer.start(1.25)
		
func show_screen():
	screen.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	in_screen = true
	
func _input(event):
	if event is InputEventMouseButton and not in_screen:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			
func open_file():
	subtitles.queue_text("Hm, no, that's kind of boring, let's open something else", 2)

func open_dont():
	text_file.visible = true
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = true;
	timer.connect("timeout", show_app)
	timer.start(1.25)
	
func show_app():
	game.visible = true
	
func open_game():
	var fader = get_tree().create_tween()
	black.visible = true
	fader.tween_property(black, "modulate:a", 1, 2)
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = true;
	timer.connect("timeout", change_scene)
	timer.start(2)
	
func change_scene():
	get_tree().change_scene_to_file("res://World/puzzle_1/World_1.tscn")
	
