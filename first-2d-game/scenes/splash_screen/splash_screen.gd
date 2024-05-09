extends CanvasLayer

var progress_tween: SceneTreeTween


func _ready() -> void:
	
	progress_tween = create_tween()
	progress_tween.tween_property($ProgressBar, "value", 100, 2)
	
	GlobalMusic.play_main_music()
	

func _on_ProgressBar_value_changed(value) -> void:

	if value >= 100:
		SceneTransaction._change_scene("res://Main.tscn")
