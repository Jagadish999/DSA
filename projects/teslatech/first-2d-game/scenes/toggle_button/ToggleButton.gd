extends Button

var _is_button_on: bool = false;
var _tween: Tween

onready var _circle: Object = $Circle


func _ready():
	_tween = Tween.new()
	add_child(_tween)


func set_initial_state(p_is_button_on: bool) -> void:
	_is_button_on = p_is_button_on
	
	if _is_button_on:
		_circle.set_modulate(Color(0, 255, 0))
		_circle.rect_position.x = 0
	else:
		_circle.set_modulate(Color(100, 100, 100))
		_circle.rect_position.x = 100


func _make_button_toggle() -> void:
	if _is_button_on:
		_circle.set_modulate(Color(0, 255, 0))
		_tween.interpolate_property(
			_circle, 
			"rect_position:x", 
			_circle.rect_position.x,
			0, 
			0.3,
			Tween.TRANS_LINEAR,
			Tween.EASE_IN_OUT
		)

	else:
		_circle.set_modulate(Color(100, 100, 100))
		_tween.interpolate_property(
			_circle,
			"rect_position:x",
			_circle.rect_position.x,
			100,
			0.3,
			Tween.TRANS_LINEAR,
			Tween.EASE_IN_OUT
		)

	_tween.start()


func toggleButton_pressed():
	_is_button_on = not _is_button_on
	_make_button_toggle()

