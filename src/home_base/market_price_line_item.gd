class_name MarketPriceLineItem extends HBoxContainer

var coin: CoinResource

@onready var icon: TextureRect = %Icon
@onready var coin_name: Label = %CoinName
@onready var price: Label = %Price
@onready var direction_sprite: AnimatedSprite2D = $Direction/DirectionSprite


func _on_price_changed(coin_type: Enum.CoinType, _price: float):
	if coin.type != coin_type:
		return

	var price_history = State.Market.prices[coin_type]
	price.text = "%.02f" % price_history.current_price

	var history_size = price_history.history.size()
	var is_up := true

	if history_size > 1:
		# Calculate the index of the previous price in the history
		var previous_index = history_size - 2
		is_up = price_history.current_price > price_history.history[previous_index]

	if is_up:
		direction_sprite.play("up")
	else:
		direction_sprite.play("down")


func activate(_coin: CoinResource):
	coin = _coin
	icon.texture = coin.icon
	coin_name.text = coin.name

	_on_price_changed(coin.type, 0.0)
	State.Market.price_changed.connect(_on_price_changed)
