extends Control

onready var back_button: Object = $VBoxContainer/BackRedirectBtn/BackButton
onready var back_button_img: Object = $VBoxContainer/BackRedirectBtn/BackButton/TextureRect

onready var music_toggle_btn: Object =$VBoxContainer/MarginContainer/VBoxContainer/MusicToggleBtn/MainMusicToggle
onready var sfx_toggle_btn: Object = $VBoxContainer/MarginContainer/VBoxContainer/SfxToggle/SfxSoundToggle
onready var game_toggle_btn: Object = $VBoxContainer/MarginContainer/VBoxContainer/GameSoundToggle/GameSoundToggle

onready var main_music_state: bool = GlobalMusic.get_main_music_state()
onready var sfx_sound_state: bool = GlobalMusic.get_sfx_sound_state()
onready var game_sound_state: bool = GlobalMusic.get_game_sound_state()


func _ready():
	music_toggle_btn.set_initial_state(main_music_state)
	sfx_toggle_btn.set_initial_state(sfx_sound_state)
	game_toggle_btn.set_initial_state(game_sound_state)


func _on_BackButton_pressed():
	GlobalMusic.play_button_sound()
	SceneTransaction._change_scene("res://scenes/main/main.tscn")


func _on_ImgSlidingTimer_timeout() -> void:
	var m_tween: Tween = Tween.new()
	add_child(m_tween)
	
	m_tween.interpolate_property(
		back_button_img,
		"rect_position:x",
		back_button_img.rect_position.x,
		-50,
		0.8,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	m_tween.start()
	$ImgRestoreTimer.start()


func _on_ImgRestoreTimer_timeout():
	var m_tween: Tween = Tween.new()
	add_child(m_tween)

	m_tween.interpolate_property(
		back_button_img,
		"rect_position:x",
		300,
		181,
		0.8,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)

	m_tween.start()
	$ImgRestoreTimer.stop()


func _on_MainMusicToggle_pressed():
	GlobalMusic.play_button_sound()
	music_toggle_btn.toggleButton_pressed()
	main_music_state = not main_music_state
	
	GlobalMusic.set_main_music_state(main_music_state)
	GlobalMusic.play_main_music()


func _on_SfxSoundToggle_pressed():
	sfx_toggle_btn.toggleButton_pressed()
	sfx_sound_state = not sfx_sound_state
	
	GlobalMusic.set_sfx_sound_state(sfx_sound_state)
	GlobalMusic.play_button_sound()


func _on_GameSoundToggle_pressed():
	GlobalMusic.play_button_sound()
	game_toggle_btn.toggleButton_pressed()
	game_sound_state = not game_sound_state
	
	GlobalMusic.set_game_sound_state(game_sound_state)
