extends Area3D
@onready var subtitles = $"../CanvasLayer/Subtitles"
var _has_played = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_body_entered(body):
	if body is Player and !_has_played:
		subtitles.intro()
		_has_played = true
