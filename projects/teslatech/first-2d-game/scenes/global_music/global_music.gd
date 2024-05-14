extends Node2D

var _is_main_sound_played: bool = true
var _is_sfx_sound_played: bool = true
var _is_game_sound_played: bool = true


func set_main_music_state(p_is_main_music_played: bool) -> void:
	_is_main_sound_played = p_is_main_music_played


func set_sfx_sound_state(p_is_sfx_sound_played: bool) -> void:
	_is_sfx_sound_played = p_is_sfx_sound_played


func set_game_sound_state(p_is_game_sound_played: bool) -> void:
	_is_game_sound_played = p_is_game_sound_played


func get_main_music_state() -> bool:
	return _is_main_sound_played


func get_sfx_sound_state() -> bool:
	return _is_sfx_sound_played


func get_game_sound_state() -> bool:
	return _is_game_sound_played


func play_main_music() -> void:
	if _is_main_sound_played:
		$MainMusic.play()
	else:
		$MainMusic.stop()


func stop_main_music() -> void:
		$MainMusic.stop()


func play_game_music() -> void:
	if _is_game_sound_played:
		$GameMusic.play()


func stop_game_music() -> void:
	$GameMusic.stop()


func play_death_sound() -> void:
	if _is_game_sound_played:
		$DeathSound.play()


func play_button_sound() -> void:
	if _is_sfx_sound_played:
		$ButtonClick.play()
		$ButtonClickTimer.start()


func _on_ButtonClickTimer_timeout():
	$ButtonClick.stop()
