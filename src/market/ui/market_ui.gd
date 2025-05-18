extends Control

@onready var item_list: ItemList = %ItemList
@onready var coin_name: Label = %CoinName
@onready var icon: TextureRect = %Icon
@onready var price: Label = %Price
@onready var quantity: HSlider = %Quantity
@onready var quantity_label: Label = %QuantityLabel
@onready var sell_button: Button = %SellButton


func _ready() -> void:
	# Clears the temp test data we need for editor view
	item_list.clear()

	var coins: Array[CoinResource] = ItemTypes.coins.values()
	for i in coins.size():
		var coin = coins[i]
		item_list.add_item(coin.name, coin.icon)
		item_list.set_item_metadata(i, coin)

	item_list.item_selected.connect(_on_item_selected)

	#add a coin for testing
	#Service.Inventory.add_coins(Enum.CoinType.SHIT_COIN, 2)

	quantity.value_changed.connect(_on_quantity_value_changed)

	# Defaulting first item so that temp test data doesn't show
	_on_item_selected(0)
	item_list.select(0)


func _on_item_selected(index: int):
	var coin: CoinResource = item_list.get_item_metadata(index)
	coin_name.text = coin.name
	icon.texture = coin.icon
	price.text = "$%.2f" % State.Market.prices[coin.type].current_price

	# set max value to whats in inventory
	var amount_owned = State.Inventory.coins.get(coin.type, 0)

	quantity.max_value = amount_owned
	quantity.value = amount_owned
	_on_quantity_value_changed(quantity.value)


func _on_quantity_value_changed(value: float):
	quantity_label.text = "%d" % value
