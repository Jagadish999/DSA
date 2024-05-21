extends RigidBody2D


const MAX_SCALE_RATIO = 1.8

var __

#For Random number generation
var _rng

# constants holding scale of sprite and collision shape
var initial_sprite_scale: Vector2
var initial_collision_scale: Vector2

# initial values physics for fish movement
var _initial_position: Vector2
var _intial_angle_degree: float
var _initial_angle_radians: float
var _speed: float = 150.0

#var _initial_position: Vector2
var _initial_velocity_x: float
var _initial_rotation: float

# tweens for changing size and speed property
var _size_changing_tween: Tween
var _speed_increase_tween: Tween

# blinking count while moving fast and rotation flag
var _blink_count: int = 15
var _rotation_needed: bool = true

onready var _animated_sprite := $AnimatedSprite
onready var _blink_timer := $BlinkTimer
onready var _collision_shape = $CollisionShape2D


func _ready() -> void:
	
	_size_changing_tween = Tween.new()
	add_child(_size_changing_tween)

	_speed_increase_tween = Tween.new()
	add_child(_speed_increase_tween)
	
	initial_sprite_scale = _animated_sprite.scale
	initial_collision_scale = _collision_shape.scale


# Rotate Fish after reaching screen edges
#func _process(_delta: float) -> void:
#	if _rotation_needed and is_equal_approx(self.rotation, -1.6) and self.position.x > 980:
#		_rotate_fish()
#	elif _rotation_needed and is_equal_approx(self.rotation, 1.6) and self.position.x < 50:
#		_rotate_fish()


# Receives position, velocity and rotation degree form main scene
func initialize(p_position: Vector2) -> void:

	_initial_position = p_position
	var m_random_angle: float

		
#	print(p_position)
#	_initial_velocity_x = p_velocity_x
#	_initial_rotation = p_rotation_degree

	_set_initial_values()


# Sets starting values of fish
func _set_initial_values() -> void:
	self.position =  _initial_position
#	self.linear_velocity.x = _initial_velocity_x
#	self.rotation = _initial_rotation

	var m_velocity_x = _speed * cos(_initial_angle_radians)
	var m_velocity_y = _speed * sin(_initial_angle_radians)

	var m_linear_velocity = Vector2(m_velocity_x, m_velocity_y)

#	self.linear_velocity = m_linear_velocity
#	self.rotation = -_angle_radians


# increases to maximum scale and stops rigit body movement
func _on_fish_mouse_entered() -> void:
	self.linear_velocity.x = 0

	if _size_changing_tween.is_active():
		__ = _size_changing_tween.remove(_animated_sprite, "scale")
		__ = _size_changing_tween.remove(_collision_shape, "scale")

	if _size_changing_tween.is_active():
		__ = _size_changing_tween.stop_all()

	_set_tween_property(
		"size",
		_animated_sprite,
		"scale",
		_animated_sprite.scale,
		initial_sprite_scale * MAX_SCALE_RATIO,
		1.0,
		0.8
	)
	_set_tween_property(
		"size",
		_collision_shape,
		"scale",
		_collision_shape.scale,
		initial_collision_scale * MAX_SCALE_RATIO,
		1.0,
		0.8
	)

	__ = _size_changing_tween.start()


func _set_overwritten_velocity(p_velocity_x: float) -> void:
	self.linear_velocity.x = p_velocity_x


func _on_Fish_mouse_exited() -> void:
#	_set_overwritten_velocity(_initial_velocity_x)

	if _size_changing_tween.is_active():
		__ = _size_changing_tween.remove(_animated_sprite, "scale")
		__ = _size_changing_tween.remove(_collision_shape, "scale")

	if (!is_equal_approx(_animated_sprite.scale.x, initial_sprite_scale.x) and
		!is_equal_approx(_animated_sprite.scale.y, initial_sprite_scale.y)):
		_set_tween_property(
			"size",
			_animated_sprite,
			"scale",
			_animated_sprite.scale,
			initial_sprite_scale,
			1.0,
			0
		)

		_set_tween_property(
			"size",
			_collision_shape,
			"scale",
			_collision_shape.scale,
			initial_collision_scale,
			1.0,
			0
		)
		__ = _size_changing_tween.start()


func _rotate_fish() -> void:
	if _speed_increase_tween.is_active():
		__ = _speed_increase_tween.remove(self, "linear_velocity:x")
	
	_rotation_needed = false

	_initial_position = self.position
	_initial_velocity_x = _initial_velocity_x * (-1)
	_initial_rotation = _initial_rotation * (-1)

	_set_initial_values()

	yield(get_tree().create_timer(1.0), "timeout")
	_rotation_needed = true


func _on_Fish_input_event(_viewport, p_event: InputEvent, _shape_idx) -> void:
	if p_event is InputEventMouseButton:
		if p_event.is_pressed():
			_blink_timer.start()
			_on_Fish_mouse_exited()

			_set_tween_property(
				"speed",
				self,
				"linear_velocity:x",
				_initial_velocity_x * 4,
				_initial_velocity_x,
				1.5,
				0
			)

			__ = _speed_increase_tween.start()


func _on_BlinkTimer_timeout() -> void:
	_blink_count -= 1;

	if _blink_count % 2 == 0:
		_animated_sprite.visible = false
	else:
		_animated_sprite.visible = true

	if _blink_count < 1:
		_animated_sprite.visible = true
		_blink_timer.stop()
		_blink_count = 15


func _set_tween_property(
		p_tween_name: String, 
		p_object_name: Object,
		p_property_name: String,
		p_initial_value,
		p_final_value,
		p_animation_duration: float,
		p_delay_time: float
	) -> void:
	if p_tween_name == "size":
		__ = _size_changing_tween.interpolate_property(
			p_object_name,
			p_property_name,
			p_initial_value,
			p_final_value,
			p_animation_duration,
			Tween.TRANS_LINEAR,
			Tween.EASE_IN_OUT,
			p_delay_time
		)

	elif p_tween_name == "speed":
		__ = _speed_increase_tween.interpolate_property(
			p_object_name,
			p_property_name,
			p_initial_value,
			p_final_value,
			p_animation_duration,
			Tween.TRANS_LINEAR,
			Tween.EASE_IN_OUT,
			p_delay_time
		)
