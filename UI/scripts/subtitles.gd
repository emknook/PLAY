extends Control

@onready var rich_text_label = $RichTextLabel
@onready var timer = Timer.new()
var subtitle_queue: Array = []
var is_showing_subtitle
var is_showing_instruction

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	add_child(timer)
	timer.one_shot = true;
	timer.connect("timeout", _on_timer_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _process_queue():
	if not is_showing_subtitle and subtitle_queue.size() > 0:
		var current = subtitle_queue.pop_front()
		set_text(current["text"], current["duration"])

func set_text(text: String, duration):
	rich_text_label.text = text
	is_showing_subtitle = true
	visible = true
	if duration == null:
		duration = 3.0
	timer.start(duration)
	
func _on_timer_timeout():
	visible = false
	is_showing_subtitle = false
	_process_queue()
	
func queue_text(text, duration):
	subtitle_queue.append({"text": text, "duration": duration})
	_process_queue()
	
func clear():
	visible = false
	rich_text_label.text = ""
	is_showing_instruction = false
	is_showing_subtitle = false
	
func intro():
	queue_text("Hi there! Welcome to this world, this is just a small preview of what awaits you.", null)
	queue_text("Let's see if you've got what it takes to figure this out. It should be a doozy. Just get out of this room.", null)
	
func show_instruction(text):
	visible = true
	rich_text_label.text = text
	is_showing_instruction = true	
	
