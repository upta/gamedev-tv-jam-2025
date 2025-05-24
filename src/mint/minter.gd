extends Control

@export var coin_type: Enum.CoinType
@export var minter_resource_scene: PackedScene

@onready var icon: TextureRect = %Icon
@onready var ingredients: HBoxContainer = %Ingredients
@onready var quantity: Label = %Quantity
@onready var input_interactable: Interactable = %InputInteractable


func _ready() -> void:
	_update_display()

	input_interactable.interacted.connect(_on_input_interacted)
	State.Inventory.coin_changed.connect(_on_coin_changed)

	var _quantity = State.Inventory.coins.get(coin_type, 0)
	_on_coin_changed(coin_type, _quantity)


func _on_coin_changed(_coin_type: Enum.CoinType, _quantity: int):
	if coin_type == _coin_type:
		quantity.text = str(_quantity)


func _on_input_interacted():
	if Service.Mint.can_craft(coin_type):
		Service.Mint.mint_coin(coin_type, 1)


func _update_display():
	var recipe = Service.Mint.get_recipe_for_coin(coin_type)

	if not recipe:
		push_error("Recipe not found for coin type: %s" % coin_type)
		return

	icon.texture = recipe.coin.icon

	for child in ingredients.get_children():
		child.queue_free()

	for resource in recipe.resources:
		var _quantity = recipe.resources[resource]

		var instance = minter_resource_scene.instantiate()
		ingredients.add_child(instance)
		instance.activate(resource, _quantity)
