extends Node

@export var mob_scene : PackedScene
var score = 0

func _ready():
	randomize()

func _on_mob_timer_timeout():
	var mob_spawn_location = $MobPath/MobPathLocation
	mob_spawn_location.progress_ratio = randf()
	
	var mob = mob_scene.instantiate()
	
	add_child(mob)
	mob.position = mob_spawn_location.position
	
	var direction = mob_spawn_location.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)


func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

func new_game():
	score = 0
	$HUD.updated_score(score)
	$Player.start($StartPosition.position)
	
	$StartTimer.start()
	
	$HUD.show_message("Get ready...")
	
	await $StartTimer.timeout
	$ScoreTimer.start()
	$MobTimer.start()
	
	get_tree().call_group("mobs", "queue_free")
