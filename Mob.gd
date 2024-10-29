extends RigidBody2D

@export var min_speed = 150.0
@export var max_speed = 250.0

# Called when the node enters the scene tree for the first time.
func _ready():
	#randomize()
	$AnimatedSprite2D.play()
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free() 
