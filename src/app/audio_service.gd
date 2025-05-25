extends Node

signal volume_changed(bus: String, value: float)

var _bus_values = {}

@onready var game_music_home: AudioStreamPlayer = %GameMusicHome
@onready var game_music_mining: AudioStreamPlayer = %GameMusicMining
@onready var game_start_sfx: AudioStreamPlayer = %GameStartSFX
@onready var button_mouse_over: AudioStreamPlayer = %ButtonMouseOver
@onready var button_select_menu: AudioStreamPlayer = %ButtonSelectMenu
@onready var beep_high: AudioStreamPlayer = %BeepHigh
@onready var beep_low: AudioStreamPlayer = %BeepLow
@onready var outa_time: AudioStreamPlayer = %OutaTime
@onready var making_power: AudioStreamPlayer = %MakingPower


func _on_game_music_home_finished() -> void:
	AudioService.game_music_home.play()


func _on_game_music_mining_finished() -> void:
	AudioService.game_music_mining.play()


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
