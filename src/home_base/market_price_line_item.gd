class_name MarketPriceLineItem extends HBoxContainer

@onready var icon: TextureRect = %Icon
@onready var coin_name: Label = %CoinName
@onready var price: Label = %Price
@onready var direction: TextureRect = %Direction


func activate(coin: CoinResource):
	icon.texture = coin.icon
	coin_name.text = coin.name

	var price_history = State.Market.prices[coin.type]
	price.text = "%.02f" % price_history.current_price

	var history_size = price_history.history.size()
	var is_up := true

	if history_size > 1:
		# Calculate the index of the previous price in the history
		var previous_index = history_size - 2
		is_up = price_history.current_price > price_history.history[previous_index]

	direction.flip_v = !is_up
