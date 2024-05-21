extends Node


export (PackedScene) var fish_scene

var _fish_counter: int = 10
var _rng: Object = RandomNumberGenerator.new()
var _screen_size: Vector2

onready var _fish_spawn_location_right := $FishPathRight/LocationRight
onready var _fish_spawn_location_left := $FistPathLeft/LocationLeft


func _ready() -> void:
	_rng.randomize()
	_screen_size = get_viewport().size


# Get Some Random Positions either in X axis or Y axis
func get_random_positions() -> Vector2:
	var m_random_fish_pos: Vector2
	
	if _rng.randi_range(0, 1) == 0:
		if _rng.randi_range(0, 1) == 0:
			m_random_fish_pos.x = 0
			m_random_fish_pos.y = _rng.randf_range(1, _screen_size.y)
		else:
			m_random_fish_pos.x = _screen_size.x
			m_random_fish_pos.y = _rng.randf_range(1, _screen_size.y)
	else:
		if _rng.randi_range(0, 1) == 0:
			m_random_fish_pos.y = 0
			m_random_fish_pos.x = _rng.randf_range(1, _screen_size.x)
		else:
			m_random_fish_pos.y = _screen_size.y
			m_random_fish_pos.x = _rng.randf_range(1, _screen_size.x)
			
	return m_random_fish_pos


#func _get_random


func _on_FishTimer_timeout() -> void:
	var m_fish: Object = fish_scene.instance()
	var m_random_position = get_random_positions()

	m_fish.initialize(m_random_position)
	add_child(m_fish)

#	_fish_counter -= 1
#	if _fish_counter == 0:
#		$FishTimer.stop()
