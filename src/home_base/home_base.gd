extends Node2D

@export var tutorial_next: GUIDEAction
@export var main_context: GUIDEMappingContext
@export var tutorial_context: GUIDEMappingContext

@onready var boundary: TileMapLayer = %Boundary
@onready var camera: Camera2D = %Camera2D

@onready var tutorial_buttons: Array[Button] = [%Step1Button, %Step2Button, %Step3Button, %Step4Button, %Step5Button, %Step6Button, %Step7Button, %Step8Button]


func _ready() -> void:
	boundary.visible = false

	_set_camera_limit()

	Service.Market.fluctuate_prices()

	if State.Tutorial.should_show_opening_tutorial:
		State.Tutorial.should_show_opening_tutorial = false
		_show_tutorial()
	else:
		Service.Guide.set_local_context(main_context)


## Sets the camera limits based on the boundary tilemap.
## Subtracts 2 from the bounds size to account for the border tiles themselves,
## as we only want the camera to show the area inside the border, not the border itself.
func _set_camera_limit():
	var bounds = boundary.get_used_rect()
	var tile_size = boundary.tile_set.tile_size
	var top = (bounds.position.y * tile_size.y) + tile_size.y
	var left = (bounds.position.x * tile_size.x) + tile_size.x
	var width = (bounds.size.x - 2) * tile_size.x
	var height = (bounds.size.y - 2) * tile_size.y

	camera.limit_top = top
	camera.limit_left = left
	camera.limit_right = left + width
	camera.limit_bottom = top + height


func _show_tutorial():
	Service.Guide.set_local_context(tutorial_context)
	tutorial_next.triggered.connect(_on_tutorial_next_triggered)

	get_tree().paused = true

	$Tutorial.show()
	$Tutorial/Step1.show()
	%Step1Button.grab_focus()
	await %Step1Button.pressed
	$Tutorial/Step1.hide()

	$Tutorial/Step2.show()
	%Step2Button.grab_focus()
	await %Step2Button.pressed
	$Tutorial/Step2.hide()

	$Tutorial/Step3.show()
	%Step3Button.grab_focus()
	await %Step3Button.pressed
	$Tutorial/Step3.hide()

	$Tutorial/Step4.show()
	%Step4Button.grab_focus()
	await %Step4Button.pressed
	$Tutorial/Step4.hide()

	$Tutorial/Step5.show()
	%Step5Button.grab_focus()
	await %Step5Button.pressed
	$Tutorial/Step5.hide()

	$Tutorial/Step6.show()
	%Step6Button.grab_focus()
	await %Step6Button.pressed
	$Tutorial/Step6.hide()

	$Tutorial/Step7.show()
	%Step7Button.grab_focus()
	await %Step7Button.pressed
	$Tutorial/Step7.hide()

	$Tutorial/Step8.show()
	%Step8Button.grab_focus()
	await %Step8Button.pressed
	$Tutorial/Step8.hide()

	$Tutorial.hide()
	get_tree().paused = false

	Service.Guide.set_local_context(main_context)


func _on_tutorial_next_triggered():
	for button in tutorial_buttons:
		if button.find_parent("Step*").visible:
			button.pressed.emit.call_deferred()
			return
