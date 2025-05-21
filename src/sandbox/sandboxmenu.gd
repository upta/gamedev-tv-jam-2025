extends Control


func _ready() -> void:

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
