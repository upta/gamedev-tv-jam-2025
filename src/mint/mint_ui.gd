extends Control

@onready var back_button: Button = %BackButton
@onready var resource_list: ItemList = %ResourceList
@onready var mint_button: Button = %MintButton


func _ready() -> void:
	back_button.pressed.connect(_on_back_button_pressed)
	mint_button.pressed.connect(_on_mint_button_pressed)

	update_resource_list()


func _on_back_button_pressed():
	State.Scene.active_scene = "res://home_base/home_base.tscn"


func _on_mint_button_pressed():
	# Implement minting logic here
	pass


func update_resource_list() -> void:
	resource_list.clear()

	for coin_type in ItemTypes.recipes:
		var recipe = ItemTypes.recipes[coin_type]
		var coin = recipe.coin
		resource_list.add_item(coin.name, coin.icon)
		resource_list.set_item_metadata(resource_list.item_count - 1, recipe)
