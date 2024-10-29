extends Area2D

signal hit

@export var speed = 400.0
var screen_size


func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_up"):
		direction.y += 1
	if Input.is_action_pressed("move_down"):
		direction.y -= 1
	
	if direction.length() > 0:
		direction = direction.normalized()
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += direction * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if direction.x != 0:
		$AnimatedSprite2D.animation = "right"
		$AnimatedSprite2D.flip_v = false
		#Trail.rotation = 0
		$AnimatedSprite2D.flip_h = direction.x < 0
		
	elif direction.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = direction.y > 0
		
func start(pos):
	position = pos
	rotation = 0
	show()
	$CollisionShape2D.disabled = false

func _on_body_entered():
	hide() 
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	
