extends Node

export (PackedScene) var mob_scene

var score: int
var ready_count: int;


func _ready() -> void:
	randomize()


func game_over() -> void:
	get_tree().call_group("mobs", "queue_free")
	
	if Globals.is_game_sound_played:
		$DeathSound.play()

	$Music.stop()
	$ScoreTimer.stop()
	$MobTimer.stop()
	
	$HUD.show_game_over()


func new_game() -> void:
	GlobalMusic.stop_main_music()
	
	score = 0
	ready_count = 3

	$HUD.show_message("Get Ready")
	$ReadyCount.start()


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
	

func _on_MobTimer_timeout():
	var mob = mob_scene.instance()

	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()

	var direction = mob_spawn_location.rotation + PI / 2

	mob.position = mob_spawn_location.position

	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction

	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	add_child(mob)


func _on_Player_player_crashed():
	$Music.stop()
	game_over()


func _on_ReadyCount_timeout():
	if ready_count != 0:
		$HUD.show_message(str(ready_count))
		ready_count -= 1

	else:
		$ReadyCount.stop()
		$MobTimer.start()
		$ScoreTimer.start()
		$Player.start($StartPosition.position)
		$MobTimer.start()
		$HUD.update_score(score)
		get_tree().call_group("mobs", "queue_free")
		
		if Globals.is_game_sound_played:
			$Music.play()
