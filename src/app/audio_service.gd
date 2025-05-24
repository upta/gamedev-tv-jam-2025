extends Node

signal volume_changed(bus: String, value: float)

var _bus_values = {}

@onready var game_music_home: AudioStreamPlayer = %GameMusicHome
@onready var game_music_mining: AudioStreamPlayer = %GameMusicMining
@onready var game_start_sfx: AudioStreamPlayer = %GameStartSFX
@onready var button_mouse_over: AudioStreamPlayer = %ButtonMouseOver
@onready var button_select_menu: AudioStreamPlayer = %ButtonSelectMenu
@onready var button_select_decision: AudioStreamPlayer = %ButtonSelectDecision
@onready var victory: AudioStreamPlayer = %Victory


func set_volume(bus: String, value: float):
	var index = AudioServer.get_bus_index(bus)
	var volumne = linear_to_db(value)

	AudioServer.set_bus_volume_db(index, volumne)

	_bus_values[bus] = value

	volume_changed.emit(bus, value)


func get_volume(bus: String) -> float:
	if _bus_values.has(bus):
		return _bus_values[bus]

	return 1.0
