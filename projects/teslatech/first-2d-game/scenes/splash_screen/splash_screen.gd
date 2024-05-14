extends CanvasLayer

var progress_tween: SceneTreeTween
var rotation_tween_second: SceneTreeTween

onready var secondBar = $Clock/Second
onready var minuteBar = $Clock/Minute


func _ready() -> void:
	GlobalMusic.play_main_music()
	progress_tween = create_tween()
	progress_tween.tween_property($ProgressBar, "value", 100, 4)
	

func _on_ProgressBar_value_changed(p_value: int) -> void:
	if p_value >= 100:
		SceneTransaction._change_scene("res://scenes/main/main.tscn")


func _on_SecondTimer_timeout():
	if int(secondBar.rect_rotation) % 180 == 0:

		rotation_tween_second = create_tween()
		rotation_tween_second.tween_property(minuteBar, "rect_rotation", minuteBar.rect_rotation + 10, 0.05)

		
	secondBar.rect_rotation += 10
