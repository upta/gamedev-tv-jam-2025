extends VBoxContainer

static var bus_values: Dictionary[String, float] = {}

@onready var master: HSlider = %MasterAudioVolume
@onready var music: HSlider = %MusicAudioVolume
@onready var sfx: HSlider = %SFXAudioVolume


func _ready() -> void:
	AudioService.volume_changed.connect(_on_volume_changed)

	master.value = bus_values.get("Master", 1.0)
	music.value = bus_values.get("Music", 1.0)
	sfx.value = bus_values.get("Sound Effects", 1.0)


func _on_master_audio_volume_value_changed(value: float) -> void:
	bus_values.set("Master", value)
	AudioService.set_volume("Master", value)


func _on_music_audio_volume_value_changed(value: float) -> void:
	bus_values.set("Music", value)
	AudioService.set_volume("Music", value)


func _on_sfx_audio_volume_value_changed(value: float) -> void:
	bus_values.set("Sound Effects", value)
	AudioService.set_volume("Sound Effects", value)


func _on_volume_changed(bus: String, value: float):
	match bus:
		"Master":
			master.value = value
		"Music":
			music.value = value
		"Sound Effects":
			sfx.value = value


func _on_master_audio_volume_mouse_entered() -> void:
	AudioService.button_mouse_over.play()


func _on_music_audio_volume_mouse_entered() -> void:
	AudioService.button_mouse_over.play()


func _on_sfx_audio_volume_mouse_entered() -> void:
	AudioService.button_mouse_over.play()
