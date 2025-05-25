extends Control

@export var input_context: GUIDEMappingContext
@export var start_action: GUIDEAction


func _ready() -> void:
	Service.Guide.add_local_context(input_context)
	start_action.triggered.connect(_on_start_action_triggered)
	_music_playing()

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

	#prints(xUIScale, yUIScale)
	$butNew.size = Vector2(xUIScale, yUIScale)
	$butNew.position = Vector2(5, 5)
	$butSel.size = Vector2(xUIScale, yUIScale)
	$butSel.position = Vector2(xUIScale + 10, yUIScale + 5)
	$butOpt.size = Vector2(xUIScale, yUIScale)
	$butOpt.position = Vector2(xUIScale + 10, 5)


func _music_playing():
	if AudioService.game_music_home.playing:
		pass
	else: AudioService.game_music_home.play()


func _on_start_action_triggered():
	pass#State.Scene.active_scene = "res://main_menu/level_select/level_select.tscn"


func _on_but_new_pressed() -> void:
	AudioService.button_select_menu.play()
	State.Scene.active_scene = "res://home_base/home_base.tscn"


func _on_but_opt_pressed() -> void:
	AudioService.button_select_menu.play()
	Service.Pause.show_pause()
	#State.Scene.active_scene = "res://main_menu/settings.tscn"


func _on_but_sel_pressed() -> void:
	State.Scene.active_scene = "res://main_menu/level_select/level_select.tscn"


func _on_but_opt_mouse_entered() -> void:
	AudioService.button_mouse_over.play()


func _on_but_new_mouse_entered() -> void:
	AudioService.button_mouse_over.play()
