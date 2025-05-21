extends Control

@export var input_context: GUIDEMappingContext
@export var start_action: GUIDEAction


func _ready() -> void:
	GUIDE.enable_mapping_context(input_context, true)
	start_action.triggered.connect(_on_start_action_triggered)


func _on_start_action_triggered():
	State.Scene.active_scene = "res://game/mining_area.tscn"
