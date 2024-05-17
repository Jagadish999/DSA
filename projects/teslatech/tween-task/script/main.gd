extends Node

export (PackedScene) var fish_scene

var fish_counter: int = 15

onready var _fish_spawn_location_right = $FishPathRight/LocationRight
onready var _fish_spawn_location_left = $FistPathLeft/LocationLeft


func _ready() -> void:
	randomize()


func _on_FishTimer_timeout() -> void:
	var m_fish: Object = fish_scene.instance()
	var m_rand_velocity: int = rand_range(1024/3, 1024/6)

	if randi() % 2 == 0:
		_fish_spawn_location_right.offset = randi()
		m_fish.initialize(_fish_spawn_location_right.position, -1 * m_rand_velocity, 90)
	else:
		_fish_spawn_location_left.offset = randi()
		m_fish.initialize(_fish_spawn_location_left.position, m_rand_velocity, -90)

	add_child(m_fish)
	
	$FishTimer.stop()
