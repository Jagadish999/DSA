extends CanvasLayer

var _progress_tween: SceneTreeTween


func _ready() -> void:
	
	_progress_tween = create_tween()
	_progress_tween.tween_property($ProgressBar, "value", 100, 4)
	
	MainMusic.play()
	

func _on_ProgressBar_value_changed(value):

	if value == 100:
		SceneTransaction._change_scene("res://Main.tscn")
