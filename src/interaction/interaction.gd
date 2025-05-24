class_name Interactable extends Area2D

signal can_interact_changed(can_interact: bool)
signal interacted

@export var action: GUIDEAction

var _can_interact: bool = false:
	get:
		return _can_interact
	set(value):
		_can_interact = value
		can_interact_changed.emit(_can_interact)


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

	if action != null:
		action.triggered.connect(_on_action_triggered)


func _on_area_entered(_area: Area2D):
	_can_interact = true


func _on_area_exited(_area: Area2D):
	_can_interact = false


func _on_action_triggered() -> void:
	if _can_interact and action != null and action.value_bool:
		interacted.emit()
