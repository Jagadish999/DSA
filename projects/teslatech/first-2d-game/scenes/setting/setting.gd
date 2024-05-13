extends Control

var music_toggle
var sfx_toggle
var game_toggle

var back_button_img
var tween

func _ready():
	back_button_img = $VBoxContainer/BackRedirectBtn/BackButton/TextureRect
	tween = Tween.new()
	add_child(tween)
	
	music_toggle = $VBoxContainer/MusicToggleBtn/MusicToggle/ToggleButton
	sfx_toggle = $VBoxContainer/SfxToggle/SfxToggle/ToggleButton
	game_toggle = $VBoxContainer/HBoxContainer5/GameToggle/ToggleButton
	
	music_toggle.set_current_state(Globals.is_main_sound_played)
	sfx_toggle.set_current_state(Globals.is_sfx_sound_played)
	game_toggle.set_current_state(Globals.is_game_sound_played)


func _on_MusicToggle_pressed():
	Globals.is_main_sound_played = not Globals.is_main_sound_played
	
	if Globals.is_main_sound_played:
		GlobalMusic.play_main_music()
	else:
		GlobalMusic.stop_main_music()
		
	music_toggle.change_btn_state()


func _on_SfxToggle_pressed():
	
	Globals.is_sfx_sound_played = not Globals.is_sfx_sound_played
	sfx_toggle.change_btn_state()


func _on_GameToggle_pressed():
	
	Globals.is_game_sound_played = not Globals.is_game_sound_played
	game_toggle.change_btn_state()


func _on_BackButton_pressed():
	SceneTransaction._change_scene("res://Main.tscn")


func _on_Timer_timeout() -> void:

	$ImgSlidingMiliSec.start()


func _on_ImgSlidingMiliSec_timeout() -> void:
	
	print("Something")
	
	back_button_img.rect_position.x -= 8
	
	if back_button_img.rect_position.x <= -40:
		$ImgSlidingMiliSec.stop()
		back_button_img.rect_position.x = 103
