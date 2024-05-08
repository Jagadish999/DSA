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
	
	MainMusic.play()
	
	
func update_score(score):
	
	$ScoreLabel.text = str(score)
	
	
func _on_MessageTimer_timeout():
	
	$Message.hide()


func _on_StartButton_pressed():
	
	emit_signal("start_game")
	
	ButtonClick.play()
	ButtonClick.stop()
	
	$StartButton.hide()
	$SettingButton.hide()
	$ExitButton.hide()
	
	$ScoreLabel.show()


func _on_ExitButton_pressed():
	
	ButtonClick.play()
#	ButtonClick.stop()
#	get_tree().quit()
	


func _on_SettingButton_pressed():
	
	ButtonClick.play()
	SceneTransaction._change_scene("res://Setting.tscn")
