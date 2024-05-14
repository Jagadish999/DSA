extends CanvasLayer

signal start_game()

onready var message: Object = $VBoxContainer/Message
onready var start_btn: Object = $VBoxContainer/MarginContainer/VBoxContainer/StartButton
onready var setting_btn: Object = $VBoxContainer/MarginContainer/VBoxContainer/SettingButton
onready var exit_btn: Object = $VBoxContainer/MarginContainer/VBoxContainer/ExitButton


func show_message(text: String) -> void:
	message.text = text
	message.show()
	$MessageTimer.start()


func show_game_over() -> void:
	get_tree().call_group("mobs", "queue_free")
	show_message("Game Over")
	
	yield($MessageTimer, "timeout")
	
	message.text = "Dodge the \n Creeps!"
	
	yield(get_tree().create_timer(1), "timeout")
	
	start_btn.show()
	setting_btn.show()
	exit_btn.show()
	
	GlobalMusic.play_main_music()


func update_score(score) -> void:
	message.text = "Score: " + str(score);


func _on_MessageTimer_timeout() -> void:
	message.text = "Score: 0"


func _on_StartButton_pressed() -> void:
	start_btn.hide()
	setting_btn.hide()
	exit_btn.hide()
	GlobalMusic.play_button_sound()

	emit_signal("start_game")


func _on_SettingButton_pressed() -> void:
	GlobalMusic.play_button_sound()
	SceneTransaction._change_scene("res://scenes/setting/setting.tscn")


func _on_ExitButton_pressed() -> void:
	get_tree().quit()
