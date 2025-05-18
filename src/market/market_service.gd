class_name MarketService extends Node


func _enter_tree():
	State.Market.add_coin(preload("res://market/coins/shit_coin.tres"))


func fluxuate_prices():
	for coin_type in State.Market.prices.keys():
		var current := State.Market.prices[coin_type].current_price
		var change_percent := randf_range(-0.1, 0.1)
		var new_price := current * (1.0 + change_percent)

		State.Market.update_price(coin_type, new_price)
