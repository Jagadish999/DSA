extends Node2D


func _music_start():
	
	$AudioStreamPlayer2D.play()


func _music_stop():
	
	$AudioStreamPlayer2D.stop()
