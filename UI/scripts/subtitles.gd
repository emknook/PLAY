extends Control

@onready var rich_text_label = $RichTextLabel
@onready var timer = Timer.new()
var subtitle_queue: Array = []
var is_showing_subtitle

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	add_child(timer)
	timer.one_shot = true;
	timer.connect("timeout", _on_timer_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _process_queue():
	if not is_showing_subtitle and subtitle_queue.size() > 0:
		var current = subtitle_queue.pop_front()
		set_text(current)

func set_text(text: String, duration: float = 3.0):
	rich_text_label.text = text
	is_showing_subtitle = true
	visible = true
	timer.start(duration)
	
func _on_timer_timeout():
	visible = false
	is_showing_subtitle = false
	_process_queue()
	
func queue_text(text):
	subtitle_queue.append(text)
	_process_queue()	
	
func intro():
	queue_text("Hi there! You must be wondering what you're doing here.")
	queue_text("You are free to do what you want here")
	
	
