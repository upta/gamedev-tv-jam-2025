extends CanvasLayer

@export var pause_action: GUIDEAction

var is_enabled := true

@onready var settings: Settings = %Settings


func _ready() -> void:
	visible = false

	pause_action.triggered.connect(_on_pause_triggered)
	settings.closed.connect(_on_settings_closed)

	Service.Pause.pause_shown.connect(_on_pause_triggered)


func _on_pause_triggered():
	if !is_enabled:
		return

	visible = !visible
	get_tree().paused = !get_tree().paused


func _on_settings_closed():
	visible = false
	get_tree().paused = false
