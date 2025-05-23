extends Control

@export var ingredient_display_scene: PackedScene

@onready var back_button: Button = %BackButton
@onready var coin_list: CoinList = %CoinList
@onready var mint_button: Button = %MintButton
@onready var ingredient_container: VBoxContainer = %IngredientContainer
@onready var inventory_label: Label = %InventoryLabel
@onready var quantity: HSlider = %Quantity
@onready var quantity_label: Label = %QuantityLabel


func _ready() -> void:
	back_button.pressed.connect(_on_back_button_pressed)
	mint_button.pressed.connect(_on_mint_button_pressed)
	quantity.value_changed.connect(_on_quantity_value_changed)

	coin_list.selected.connect(_on_coin_list_selected)

	Service.Inventory.add_coins(Enum.CoinType.A_COIN, 11)
	Service.Inventory.add_coins(Enum.CoinType.BEE_COIN, 22)
	Service.Inventory.add_coins(Enum.CoinType.SEA_COIN, 33)

	Service.Inventory.add_staged_mining_resources(Enum.MiningResourceType.BLUE_CHIP, 20)
	Service.Inventory.add_staged_mining_resources(Enum.MiningResourceType.GREEN_CHIP, 20)
	Service.Inventory.add_staged_mining_resources(Enum.MiningResourceType.RED_CHIP, 20)
	Service.Inventory.add_staged_mining_resources(Enum.MiningResourceType.YELLOW_CHIP, 20)

	Service.Inventory.bank_staged_mining_resources()

	# Auto-select the first coin when UI loads
	_on_coin_list_selected(coin_list.selected_coin)


func _on_back_button_pressed():
	State.Scene.active_scene = "res://home_base/home_base.tscn"


func _on_mint_button_pressed():
	var coin = coin_list.selected_coin
	var amount_to_mint = int(quantity.value)

	# Call the mint service to handle the minting process
	var success = Service.Mint.mint_coin(coin, amount_to_mint)

	if success:
		# Refresh the UI with updated values
		_on_coin_list_selected(coin)


func _on_quantity_value_changed(value: float):
	quantity_label.text = str(int(value))


func _on_coin_list_selected(coin: CoinResource):
	# Get the recipe for the selected coin
	var recipe = Service.Mint.get_recipe_for_coin_resource(coin)

	# Clear previous ingredients
	for child in ingredient_container.get_children():
		child.queue_free()

	for resource in recipe.resources:
		var resource_quantity = recipe.resources[resource]
		var ingredient_display = ingredient_display_scene.instantiate()
		ingredient_container.add_child(ingredient_display)
		ingredient_display.activate(resource, resource_quantity)

	# Update inventory label with current coin count
	var coin_count = State.Inventory.coins.get(coin.type, 0)
	inventory_label.text = "Current: " + str(coin_count)

	var max_quantity = Service.Mint.calculate_max_craftable_quantity(recipe)

	quantity.max_value = max_quantity
	quantity.value = max_quantity
	_on_quantity_value_changed(quantity.value)
