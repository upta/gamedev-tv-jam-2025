class_name MarketState extends Node

signal price_changed(coin_type: Enum.CoinType, price: float)

var prices: Dictionary[Enum.CoinType, PriceHistory] = {}


func _to_string() -> String:
	var indent := func(text: String, prefix: String) -> String:
		return "\n".join(Array(text.split("\n")).map(func(line): return prefix + line))

	var out := "MarketState:\n"
	for coin_type in prices.keys():
		var coin_name := prices[coin_type].coin.name
		out += " - %s:\n%s\n" % [
			coin_name,
			indent.call(prices[coin_type]._to_string(), "   ")
		]
	return out


func add_coin(coin: CoinResource):
	prices[coin.type] = PriceHistory.new(coin)


func update_price(coin_type: Enum.CoinType, price: float):
	prices[coin_type].update(price)
	price_changed.emit(coin_type, price)


class PriceHistory:
	var coin: CoinResource
	var current_price: float
	var history: Array[float]

	func _init(_coin: CoinResource):
		coin = _coin
		update(coin.base_price)

	func update(price: float):
		current_price = price
		history.push_front(price)

	func _to_string() -> String:
		return "%s\n  Current Price: %.2f\n  History: %s" % [
			coin._to_string(),
			current_price,
			str(history)
		]
