extends CanvasLayer

onready var _animation_player: AnimationPlayer = $AnimationPlayer


func _change_scene(p_target: String) -> void:
	_animation_player.play("dissolve")
	yield(_animation_player, "animation_finished")
	get_tree().change_scene(p_target)
	_animation_player.play_backwards("dissolve")
