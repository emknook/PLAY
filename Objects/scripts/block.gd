extends RigidBody3D

class_name Block
@export var current_scale = 1
@export var scale_factor = 1.5
var is_animating = false
@onready var collision = $Collision
@onready var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var platform_1x_1x_1_red_2 = $platform_1x1x1_red2
var rules_applied = 0
var max_rules = 3

func _ready():
	pass

func applyRule(rule):
#	temporary test for rules
	if !is_animating and rules_applied < max_rules:
		rules_applied += 1
		if rule == "BIG":
			var bigTween = get_tree().create_tween()
			var new_scale = current_scale * scale_factor
			bigTween.set_parallel(true)
			bigTween.tween_property(collision.shape, "size", Vector3(new_scale,new_scale,new_scale), 1)
			bigTween.tween_property(platform_1x_1x_1_red_2, "scale", Vector3(new_scale,new_scale,new_scale), 1)
			current_scale = new_scale
		
