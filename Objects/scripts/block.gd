extends RigidBody3D

class_name Block
@onready var block = $"."
@onready var mesh_instance_3d = $MeshInstance3D
@export var current_scale = 1
@export var scale_factor = 1.5
var is_animating = false
@onready var collision = $Collision
@onready var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var platform_1x_1x_1_red_2 = $platform_1x1x1_red2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func applyRule(rule):
#	temporary test for rules
	if !is_animating:
		if rule == "BIG":
			var bigTween = get_tree().create_tween()
			var new_scale = current_scale * scale_factor
			bigTween.set_parallel(true)
			bigTween.tween_property(collision.shape, "size", Vector3(new_scale,new_scale,new_scale), 1)
			#bigTween.tween_property(mesh_instance_3d, "scale", Vector3(new_scale,new_scale,new_scale), 1)
			bigTween.tween_property(platform_1x_1x_1_red_2, "scale", Vector3(new_scale,new_scale,new_scale), 1)
			current_scale = new_scale
			#bigTween.tween_callback(block.queue_free)
		
# seems to temporarily (like one frame) only apply the scale...
