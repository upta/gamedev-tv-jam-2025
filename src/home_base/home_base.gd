extends Node2D

@export var input_context: GUIDEMappingContext

@onready var market: Button = %Market
@onready var shop: Button = %Shop
@onready var mint: Button = %Mint
@onready var mining: Button = %Mining

@onready var exit: Area2D = %Exit
@onready var boundary: TileMapLayer = %Boundary
@onready var camera: Camera2D = %Camera2D


func _ready() -> void:
	_set_camera_limit()
	AudioService.game_music_home.play()

	GUIDE.enable_mapping_context(input_context, true)

	market.pressed.connect(_on_market_pressed)
	shop.pressed.connect(_on_shop_pressed)
	mint.pressed.connect(_on_mint_pressed)

	exit.body_entered.connect(_on_exit_body_entered)

	#State.Inventory.add_mining_resource(Enum.MiningResourceType.BLUE_CHIP, 20)
	#State.Inventory.add_mining_resource(Enum.MiningResourceType.GREEN_CHIP, 20)
	#State.Inventory.add_mining_resource(Enum.MiningResourceType.RED_CHIP, 20)
	#State.Inventory.add_mining_resource(Enum.MiningResourceType.YELLOW_CHIP, 20)
	#
	#Service.Inventory.add_coins(Enum.CoinType.A_COIN, 5)


func _on_exit_body_entered(_body: Node2D):
	State.Scene.active_scene = "res://game/mining_area.tscn"
	AudioService.game_music_home.stop()


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
