extends Control

@export var coin_type: Enum.CoinType
@export var minter_resource_scene: PackedScene

@onready var icon: TextureRect = %Icon
@onready var ingredients: HBoxContainer = %Ingredients
@onready var quantity: Label = %Quantity
@onready var input_interactable: Interactable = %InputInteractable
@onready var output_interactable: Interactable = %OutputInteractable
@onready var fade_animation: AnimationPlayer = $FadeAnimation
@onready var highlight_animation: AnimationPlayer = $HighlightAnimation


func _ready() -> void:
	_update_recipe()

	input_interactable.interacted.connect(_on_input_interacted)
	output_interactable.interacted.connect(_on_output_interacted)

	State.Inventory.coin_changed.connect(_on_coin_changed)
	State.Inventory.held_coin_type_changed.connect(_on_held_coin_type_changed)

	var _quantity = State.Inventory.coins.get(coin_type, 0)
	_on_coin_changed(coin_type, _quantity)


func _on_coin_changed(_coin_type: Enum.CoinType, _quantity: int):
	_update_count()


func _on_held_coin_type_changed(old: Enum.CoinType, new: Enum.CoinType):
	_update_count()

	if Service.Inventory.has_held_coin():
		fade_animation.play("fade")

		if coin_type == new:
			highlight_animation.play("fade")
	else:
		fade_animation.play_backwards("fade")

		if coin_type == old:
			highlight_animation.play_backwards("fade")


func _on_input_interacted():
	if Service.Mint.can_craft(coin_type) and not Service.Inventory.has_held_coin():
		Service.Mint.mint_coin(coin_type, 1)


func _on_output_interacted():
	if Service.Inventory.has_held_coin():
		if State.Inventory.held_coin_type == coin_type:
			Service.Inventory.return_coin()
	else:
		if State.Inventory.coins.get(coin_type, 0) > 0:
			Service.Inventory.pick_up_coin(coin_type)


func _update_recipe():
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


func _update_count():
	var count = State.Inventory.coins.get(coin_type, 0)

	if State.Inventory.held_coin_type == coin_type:
		count = 0

	quantity.text = str(count)
