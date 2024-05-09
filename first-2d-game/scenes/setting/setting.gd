extends Control

var music_toggle
var sfx_toggle
var game_toggle


func _ready():
	music_toggle = $MusicToggle/ToggleButton
	sfx_toggle = $SfxToggle/ToggleButton
	game_toggle = $GameToggle/ToggleButton
	
	music_toggle.set_current_state(Globals.is_main_sound_played)
	sfx_toggle.set_current_state(Globals.is_sfx_sound_played)
	game_toggle.set_current_state(Globals.is_game_sound_played)
	

func _on_ExitButton_pressed():
	SceneTransaction._change_scene("res://Main.tscn")


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
