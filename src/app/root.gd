extends Control

@export var input_context: GUIDEMappingContext


func _ready() -> void:
	Service.Guide.add_global_context(input_context)

	State.Scene.active_scene = "res://main_menu/main_menu.tscn"
