extends Node2D

func _ready():
	play_main_music()


func play_main_music():
	$MainMusic.play()
	
func stop_main_music():
	$MainMusic.stop()
	
func play_button_sound():
	$ButtonClick.play()
	
