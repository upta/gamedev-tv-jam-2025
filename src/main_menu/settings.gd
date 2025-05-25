class_name Settings
extends PanelContainer

signal closed


func _on_master_audio_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))


func _on_music_audio_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))


func _on_sfx_audio_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound Effects"), linear_to_db(value))


func _on_close_settings_pressed() -> void:
	AudioService.button_select_menu.play()
	State.Scene.active_scene = "res://main_menu/main_menu.tscn"


func _on_close_settings_mouse_entered() -> void:
	AudioService.button_mouse_over.play()
