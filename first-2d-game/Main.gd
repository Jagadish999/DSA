extends Node

export (PackedScene) var mob_scene
var score: int

#ready count when player enters play mode
var ready_count: int;

func _ready() -> void:
	
	randomize()
#	$Music.play()
	
	
func game_over() -> void:
	
	$Music.stop()
	MainMusic.stop()
	
	$DeathSound.play()
	
	$ScoreTimer.stop()
	$MobTimer.stop()
	
	$HUD.show_game_over()

func new_game() -> void:
	
	score = 0
	ready_count = 3
	
	$ReadyCount.start()
	

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
	

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	

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
	
	get_tree().call_group("mobs", "queue_free")
	game_over()


func _on_ReadyCount_timeout():
	
	print("This is form timer")
	
	if ready_count != 0:
		
		$HUD.show_message(str(ready_count))
		ready_count -= 1
	else:
		$HUD.show_message("Get Ready")
	
		$Player.start($StartPosition.position)
		$StartTimer.start()
		$MobTimer.start()
		$HUD.update_score(score)
		get_tree().call_group("mobs", "queue_free")
		
		$ReadyCount.stop()
		
	
