extends Control


func _on_dummy_pressed() -> void:
	get_tree().change_scene_to_file("res://game/dummy_game.tscn")


func _on_mining_pressed() -> void:
	State.Scene.active_scene = "res://game/mining_area.tscn"


func _on_back_pressed() -> void:
	State.Scene.active_scene = "res://main_menu/main_menu.tscn"
