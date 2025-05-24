extends Control

@onready var back_button: Button = %BackButton
@onready var coin_list: CoinList = %CoinList
@onready var coin_name: Label = %CoinName
@onready var icon: TextureRect = %Icon
@onready var price: Label = %Price
@onready var quantity: HSlider = %Quantity
@onready var quantity_container: HBoxContainer = %QuantityContainer
@onready var quantity_label: Label = %QuantityLabel
@onready var sell_button: Button = %SellButton
@onready var graph: Graph2D = %Graph


func _ready() -> void:
	back_button.pressed.connect(_on_back_button_pressed)
	sell_button.pressed.connect(_on_sell_button_pressed)
	quantity.value_changed.connect(_on_quantity_value_changed)
	coin_list.selected.connect(_on_coin_list_selected)

	# just to get some test data in there
	Service.Market.fluxuate_prices()
	Service.Market.fluxuate_prices()
	Service.Market.fluxuate_prices()
	Service.Market.fluxuate_prices()
	Service.Market.fluxuate_prices()

	# hacky way to hide the mouse coordinate position, since it doesn't actually expose a way
	graph.get_node("PlotArea/Coordinate").visible = false

	#add some coin for testing
	Service.Inventory.add_coins(Enum.CoinType.A_COIN, 11)
	Service.Inventory.add_coins(Enum.CoinType.BEE_COIN, 22)
	Service.Inventory.add_coins(Enum.CoinType.SEA_COIN, 33)
	
	_on_coin_list_selected(coin_list.selected_coin)


func _on_back_button_pressed():
	State.Scene.active_scene = "res://home_base/home_base.tscn"


func _on_coin_list_selected(coin: CoinResource):
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
	Service.Market.sell_coins(coin_list.selected_coin.type, floori(quantity.value))

	_on_coin_list_selected(coin_list.selected_coin)
