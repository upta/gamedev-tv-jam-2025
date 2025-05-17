extends Control

@export var input_context: GUIDEMappingContext
@export var jump_action: GUIDEAction

var jump_height: float = 100.0
var jump_duration: float = 0.5
var jump_timer: float = 0.0
var is_jumping: bool = false
var jump_origin_y: float = 0.0

@onready var label: Label = $Label


func _ready():
	GUIDE.enable_mapping_context(input_context, true	)
	jump_action.triggered.connect(_on_jump_triggered)


func _physics_process(delta):
	if is_jumping:
		jump_timer += delta
		var t = jump_timer / jump_duration

		if t > 1.0:
			t = 1.0
			is_jumping = false

		var offset_y = -4 * jump_height * pow(t - 0.5, 2) + jump_height
		global_position.y = jump_origin_y - offset_y


func _on_jump_triggered():
	if is_jumping:
		return

	is_jumping = true
	jump_timer = 0.0
	jump_origin_y = global_position.y
