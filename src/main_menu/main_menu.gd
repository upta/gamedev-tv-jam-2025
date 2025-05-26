extends Control

@export var input_context: GUIDEMappingContext


func _ready() -> void:
	Service.Guide.set_local_context(input_context)

	_music_playing()


func _music_playing():
	if AudioService.game_music_home.playing:
		return

	AudioService.game_music_home.play()


func _on_start_game_pressed() -> void:
	AudioService.button_select_menu.play()
	State.Scene.active_scene = "res://home_base/home_base.tscn"


func _on_settings_pressed() -> void:
	AudioService.button_select_menu.play()
	Service.Pause.show_pause()


func _on_start_game_mouse_entered() -> void:
	AudioService.button_mouse_over.play()


func _on_settings_mouse_entered() -> void:
	AudioService.button_mouse_over.play()
