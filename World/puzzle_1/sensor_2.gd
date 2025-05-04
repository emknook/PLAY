extends Area3D
@onready var subtitles = $"../CanvasLayer/Subtitles"
var _has_played = false
@onready var black = $"../CenterContainer/Black"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body is Player and !_has_played:
		subtitles.queue_text("Wow! You did great! Now let's go back to your desk", null)
		var fader = get_tree().create_tween()
		black.visible = true
		fader.tween_property(black, "modulate:a", 1, 2)
		var timer = Timer.new()
		add_child(timer)
		timer.one_shot = true;
		timer.connect("timeout", change_scene)
		timer.start(2)

func change_scene():
	get_tree().change_scene_to_file("res://World/Desk2/Desk.tscn")
