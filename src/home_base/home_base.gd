extends Node2D

@export var input_context: GUIDEMappingContext

@onready var market: Button = %Market
@onready var shop: Button = %Shop
@onready var mint: Button = %Mint
@onready var mining: Button = %Mining

@onready var exit: Area2D = %Exit


func _ready() -> void:
	GUIDE.enable_mapping_context(input_context, true)

	market.pressed.connect(_on_market_pressed)
	shop.pressed.connect(_on_shop_pressed)
	mint.pressed.connect(_on_mint_pressed)

	exit.body_entered.connect(_on_exit_body_entered)


func _on_exit_body_entered(_body: Node2D):
	State.Scene.active_scene = "res://game/mining_area.tscn"


func _on_market_pressed():
	State.Scene.active_scene = "res://market/ui/market_ui.tscn"


func _on_shop_pressed():
	return


func _on_mint_pressed():
	State.Scene.active_scene = "res://mint/ui/mint_ui.tscn"
