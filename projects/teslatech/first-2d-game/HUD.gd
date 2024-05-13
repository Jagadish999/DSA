extends CanvasLayer

signal start_game


func show_message(text: String) -> void:
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


func show_game_over() -> void:
	print("show game over")
#	print("Before Releasing Mobs")
#	print("After Releasing Mobs")
	
	get_tree().call_group("mobs", "queue_free")
	show_message("Game Over")
	
	yield($MessageTimer, "timeout")
	
	$Message.text = "Dodge the \n Creeps!"
	$Message.show()
	
	yield(get_tree().create_timer(1), "timeout")
	
	$StartButton.show()
	$SettingButton.show()
	$ExitButton.show()
	
	if Globals.is_main_sound_played:
		GlobalMusic.play_main_music()


func update_score(score) -> void:
	$Message.text = "Score: " + str(score);


func _on_MessageTimer_timeout() -> void:
	$Message.text = "Score: 0"


func _on_StartButton_pressed() -> void:
	if Globals.is_sfx_sound_played:
		GlobalMusic.play_button_sound()
	
	$StartButton.hide()
	$SettingButton.hide()
	$ExitButton.hide()

	emit_signal("start_game")


func _on_SettingButton_pressed() -> void:
	if Globals.is_sfx_sound_played:
		GlobalMusic.play_button_sound()
		
	SceneTransaction._change_scene("res://scenes/setting/setting.tscn")


func _on_ExitButton_pressed() -> void:
	get_tree().quit()
