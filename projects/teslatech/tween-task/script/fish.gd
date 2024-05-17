extends RigidBody2D

var _initial_position: Vector2
var _initial_velocity_x: float
var _initial_rotation: float

var _size_increasing_tween: Tween
var _size_decreasing_tween: Tween
var _speed_increase_tween: Tween

var _blink_count: int = 15

onready var _animated_sprite = $AnimatedSprite
onready var _blink_timer = $BlinkTimer
onready var _screen_size = get_viewport_rect().size


func _ready() -> void:
	print(_screen_size)
	print(self.position.x)
	_size_increasing_tween = Tween.new()
	add_child(_size_increasing_tween)
	
	_size_decreasing_tween = Tween.new()
	add_child(_size_decreasing_tween)
	
	_speed_increase_tween = Tween.new()
	add_child(_speed_increase_tween)


func _process(delta: float) -> void:
	print(self.position.x)
	
	if self.rotation_degrees == -90 and self.position.x < 156:
		print("Turn")
	pass


func _on_fish_mouse_entered() -> void:
	self.linear_velocity.x = 0
	if _size_decreasing_tween.is_active():
		_size_decreasing_tween.stop_all()

	_size_increasing_tween.interpolate_property(
		_animated_sprite,
		"scale",
		_animated_sprite.scale,
		Vector2(1.1, 1.1),
		1,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT,
		0.5
	)
	_size_increasing_tween.start()


func _on_Fish_mouse_exited() -> void:
	self.linear_velocity.x = _initial_velocity_x
	if _size_increasing_tween.is_active():
		_size_increasing_tween.stop_all()

	if !is_equal_approx(_animated_sprite.scale.x, 0.6) and !is_equal_approx(_animated_sprite.scale.y, 0.6):
		_size_decreasing_tween.interpolate_property(
			_animated_sprite,
			"scale",
			_animated_sprite.scale,
			Vector2(0.6, 0.6),
			1,
			Tween.TRANS_LINEAR,
			Tween.EASE_IN_OUT,
			0.2
		)
		_size_decreasing_tween.start()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	if _size_increasing_tween.is_active():
		_size_increasing_tween.stop_all()
		
	if _size_decreasing_tween.is_active():
		_size_decreasing_tween.stop_all()
		
	if _speed_increase_tween.is_active():
		_speed_increase_tween.stop_all()
		
	initialize(self.position, _initial_velocity_x * -1.0, _initial_rotation * -1.0)


func initialize(p_position: Vector2, p_velocity_x: float, p_rotation_degree: float) -> void:
	_initial_position = p_position
	_initial_velocity_x = p_velocity_x
	_initial_rotation = p_rotation_degree

	self.position =  _initial_position
	self.linear_velocity.x = _initial_velocity_x
	self.rotation_degrees = _initial_rotation


func _on_Fish_input_event(viewport, event, shape_idx):
	
	if event is InputEventMouseButton:
		if event.is_pressed():
			_blink_timer.start()
			_on_Fish_mouse_exited()
			_speed_increase_tween.interpolate_property(
				self,
				"linear_velocity:x",
				_initial_velocity_x * 4,
				_initial_velocity_x,
				1.6
			)
			_speed_increase_tween.start()


func _on_BlinkTimer_timeout():
	_blink_count -= 1;
	
	if _blink_count % 2 == 0:
		_animated_sprite.visible = false
	else:
		_animated_sprite.visible = true
	
	if _blink_count < 1:
		_animated_sprite.visible = true
		_blink_timer.stop()
		_blink_count = 15
