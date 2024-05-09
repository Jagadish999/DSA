extends CanvasLayer

signal start_game


func show_message(text):
	
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


func show_game_over():
	
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	
	$Message.text = "Dodge the \n Creeps!"
	$Message.show()
	
	yield(get_tree().create_timer(1), "timeout")
	
	$StartButton.show()
	$SettingButton.show()
	$ExitButton.show()
	
	GlobalMusic.play_main_music()


func update_score(score):
	
	$Message.text = "Score: " + str(score);


func _on_MessageTimer_timeout():
	
	$Message.text = "Score: 0"


func _on_StartButton_pressed():
	GlobalMusic.play_button_sound()
	
	$StartButton.hide()
	$SettingButton.hide()
	$ExitButton.hide()

	emit_signal("start_game")


func _on_SettingButton_pressed() -> void:
	GlobalMusic.play_button_sound()
	SceneTransaction._change_scene("res://scenes/setting/setting.tscn")
	

func _on_ExitButton_pressed() -> void:
	get_tree().quit()
