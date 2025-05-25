extends Node2D

@export var input_context: GUIDEMappingContext

@onready var market: Button = %Market
@onready var shop: Button = %Shop
@onready var mint: Button = %Mint
@onready var mining: Button = %Mining

@onready var boundary: TileMapLayer = %Boundary
@onready var camera: Camera2D = %Camera2D


func _ready() -> void:
	_set_camera_limit()

	GUIDE.enable_mapping_context(input_context, true)

	market.pressed.connect(_on_market_pressed)
	shop.pressed.connect(_on_shop_pressed)
	mint.pressed.connect(_on_mint_pressed)

	if State.Tutorial.should_show_opening_tutorial:
		State.Tutorial.should_show_opening_tutorial = false
		_show_tutorial()


func _on_market_pressed():
	State.Scene.active_scene = "res://market/ui/market_ui.tscn"


func _on_shop_pressed():
	return


func _on_mint_pressed():
	State.Scene.active_scene = "res://mint/ui/mint_ui.tscn"


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
	get_tree().paused = true
	$Tutorial.show()
	$Tutorial/Step1.show()
	await %Step1Button.pressed
	$Tutorial/Step1.hide()

	$Tutorial/Step2.show()
	await %Step2Button.pressed
	$Tutorial/Step2.hide()

	$Tutorial/Step3.show()
	await %Step3Button.pressed
	$Tutorial/Step3.hide()

	$Tutorial/Step4.show()
	await %Step4Button.pressed
	$Tutorial/Step4.hide()

	$Tutorial/Step5.show()
	await %Step5Button.pressed
	$Tutorial/Step5.hide()

	$Tutorial/Step6.show()
	await %Step6Button.pressed
	$Tutorial/Step6.hide()

	$Tutorial/Step7.show()
	await %Step7Button.pressed
	$Tutorial/Step7.hide()

	$Tutorial/Step8.show()
	await %Step8Button.pressed
	$Tutorial/Step8.hide()

	$Tutorial.hide()
	get_tree().paused = false
