extends Control

@export var input_context: GUIDEMappingContext
@export var start_action: GUIDEAction


func _ready() -> void:
	GUIDE.enable_mapping_context(input_context, true)
	start_action.triggered.connect(_on_start_action_triggered)

	# get size scale to 1024x1024
	var viewPort = get_viewport().get_visible_rect().size

	var xScale = viewPort.x / 1024
	var yScale = viewPort.y / 1024

	$AnimatedSprite2D.scale = Vector2(xScale, yScale)
	$AnimatedSprite2D.position = Vector2(viewPort.x / 2, viewPort.y / 2)
	$AnimatedSprite2D.play("default")
	# get scale to 500 x 250 for menu area then divide by 2 for 2 row/col
	var xUIScale = (xScale) * 250
	var yUIScale = (yScale) * 125

	prints(xUIScale, yUIScale)
	$butNew.size = Vector2(xUIScale, yUIScale)
	$butNew.position = Vector2(5, 5)
	$butSel.size = Vector2(xUIScale, yUIScale)
	$butSel.position = Vector2(xUIScale + 10, 5)
	$butOpt.size = Vector2(xUIScale, yUIScale)
	$butOpt.position = Vector2(5, yUIScale + 5)
	$butQuit.size = Vector2(xUIScale, yUIScale)
	$butQuit.position = Vector2(xUIScale + 10, yUIScale + 5)


func _on_start_action_triggered():
	pass#State.Scene.active_scene = "res://main_menu/level_select/LevelSelect.tscn"


func _on_but_new_pressed() -> void:
	State.Scene.active_scene = "res://game/mining_area.tscn"


func _on_but_opt_pressed() -> void:
	prints("options button")


func _on_but_quit_pressed() -> void:
	get_tree().quit()


func _on_but_sel_pressed() -> void:
	State.Scene.active_scene = "res://main_menu/level_select/LevelSelect.tscn"


func _on_but_opt_toggled(toggled_on: bool) -> void:
	prints("Toggled")
	# Replace with function body.
