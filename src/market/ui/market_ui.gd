extends Control

@onready var item_list: ItemList = %ItemList
@onready var coin_name: Label = %CoinName
@onready var icon: TextureRect = %Icon
@onready var price: Label = %Price
@onready var quantity: HSlider = %Quantity
@onready var quantity_container: HBoxContainer = %QuantityContainer
@onready var quantity_label: Label = %QuantityLabel
@onready var sell_button: Button = %SellButton
@onready var graph: Graph2D = %Graph


func _ready() -> void:
	# just to get some test data in there
	Service.Market.fluxuate_prices()
	Service.Market.fluxuate_prices()
	Service.Market.fluxuate_prices()
	Service.Market.fluxuate_prices()
	Service.Market.fluxuate_prices()

	# hacky way to hide the mouse coordinate position, since it doesn't actually expose a way
	graph.get_node("PlotArea/Coordinate").visible = false
	
	# Clears the temp test data we need for editor view
	item_list.clear()

	var coins: Array[CoinResource] = ItemTypes.coins.values()

	for i in coins.size():
		var coin = coins[i]
		item_list.add_item(coin.name, coin.icon)
		item_list.set_item_metadata(i, coin)

	item_list.item_selected.connect(_on_item_selected)

	#add some coin for testing
	Service.Inventory.add_coins(Enum.CoinType.SHIT_COIN, 11)
	Service.Inventory.add_coins(Enum.CoinType.DOS_COIN, 22)
	Service.Inventory.add_coins(Enum.CoinType.A_COIN, 33)

	quantity.value_changed.connect(_on_quantity_value_changed)

	# Defaulting first item so that temp test data doesn't show
	_on_item_selected(0)
	item_list.select(0)

	sell_button.pressed.connect(_on_sell_button_pressed)


func _on_item_selected(index: int):
	var coin: CoinResource = item_list.get_item_metadata(index)
	var price_history = State.Market.prices[coin.type]

	coin_name.text = coin.name
	icon.texture = coin.icon
	price.text = "$%.2f" % price_history.current_price

	# set max value to whats in inventory
	var amount_owned = State.Inventory.coins.get(coin.type, 0)

	# Hide the sell display if they don't own any coin
	quantity_container.visible = amount_owned > 0
	sell_button.visible = amount_owned > 0

	quantity.max_value = amount_owned
	quantity.value = amount_owned
	_on_quantity_value_changed(quantity.value)

	graph.remove_all()

	var plot_item := graph.add_plot_item(" ", Color.WEB_GREEN)
	var max_value := 0.0

	for i in price_history.history.size():
		var item: float = price_history.history[i]

		plot_item.add_point(Vector2(i, item))
		max_value = maxf(max_value, item)

	graph.y_max = max_value * 1.5

	#prints(max_value, graph.y_max)


func _on_quantity_value_changed(value: float):
	quantity_label.text = "%d" % value


func _on_sell_button_pressed():
	# Find the selected item in the list and grab it's value
	var selected = item_list.get_selected_items()
	if selected.size() == 0:
		return

	# There should only ever be 1 selected item
	var index = selected[0]

	var coin: CoinResource = item_list.get_item_metadata(index)
	Service.Market.sell_coins(coin.type, floori(quantity.value))

	_on_item_selected(index)
