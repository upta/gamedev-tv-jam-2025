extends Control


func _on_dummy_pressed() -> void:
	get_tree().change_scene_to_file("res://game/dummy_game.tscn")


func _on_mining_pressed() -> void:
	State.Scene.active_scene = "res://game/mining_area.tscn"


func _on_back_pressed() -> void:
	State.Scene.active_scene = "res://main_menu/main_menu.tscn"



func _on_home_base_pressed() -> void:
	State.Scene.active_scene = "res://home_base/home_base.tscn"

func _on_button_pressed() -> void:
	State.Scene.active_scene = "res://sandbox/theme_sandbox.tscn"
