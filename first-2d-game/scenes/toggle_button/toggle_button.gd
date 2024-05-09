extends Control

var is_button_on: bool = true;
var tween

var base
var circle


func _ready():
	tween = Tween.new()
	add_child(tween)
	
	base = $Base
	circle = $Circle
	

func set_current_state(p_is_button_on: bool):
	is_button_on = p_is_button_on
	
	if is_button_on:
		circle.set_modulate(Color(0, 255, 0))
		circle.rect_position.x = 10
		
	else:
		circle.set_modulate(Color(255, 0, 0))
		circle.rect_position.x = 50
		

func change_btn_state() -> void:
	is_button_on = not is_button_on
	
	if is_button_on:
		circle.set_modulate(Color(0, 255, 0))
		
		tween.interpolate_property(
		circle, 
		"rect_position:x", 
		circle.rect_position.x,
		10, 
		0.4,
		Tween.TRANS_LINEAR,
		tween.EASE_IN_OUT)
		
	else:
		circle.set_modulate(Color(165, 165, 165))
		
		tween.interpolate_property(
		circle,
		"rect_position:x",
		circle.rect_position.x,
		50, 
		0.4,
		Tween.TRANS_LINEAR,
		tween.EASE_IN_OUT)
		
	tween.start()
