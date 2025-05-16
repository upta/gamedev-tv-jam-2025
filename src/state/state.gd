extends Node

var Scene := StateScene.new()


func _enter_tree() -> void:
	add_child(Scene)
