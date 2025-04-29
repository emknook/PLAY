extends Node3D

@export var scale_factor = 1.5
var changed_scale
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if changed_scale:
		scale = changed_scale
	pass

func applyRule(rule):
#	temporary test for rules
# seems to temporarily (like one frame) only apply the scale...
	if rule == "BIG":
		print_debug("scale before:", scale)
		scale *= Vector3(scale_factor, scale_factor, scale_factor)
		changed_scale = scale
		print_debug("Scaled to:", scale)
