extends Node2D

@onready var market: Button = %Market
@onready var shop: Button = %Shop
@onready var mining: Button = %Mining


func _ready() -> void:
	market.pressed.connect(_on_market_pressed)
	shop.pressed.connect(_on_shop_pressed)
	mining.pressed.connect(_on_mining_pressed)


func _on_market_pressed():
	State.Scene.active_scene = "res://market/ui/market_ui.tscn"


func _on_shop_pressed():
	return


func _on_mining_pressed():
	return
