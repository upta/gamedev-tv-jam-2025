class_name StateScene extends Node

signal scene_changed(scene_path: String)

var active_scene: String:
	get:
		return active_scene
	set(value):
		if active_scene == value:
			return

		active_scene = value
		scene_changed.emit(value)
