class_name MarketService extends Node


func _enter_tree():
	for coin in ItemTypes.coins.values():
		State.Market.add_coin(coin)


func fluxuate_prices():
	for coin_type in State.Market.prices.keys():
		var current := State.Market.prices[coin_type].current_price
		# Base upward trend factor
		var trend_factor := 0.05  # 5% upward trend
		# Random variation from -15% to +15%
		var random_factor := randf_range(-0.15, 0.15)
		# Combined change (can go slightly negative but mostly positive)
		var change_percent := trend_factor + random_factor
		var new_price := current * (1.0 + change_percent)

		State.Market.update_price(coin_type, new_price)


func sell_coins(coin_type: Enum.CoinType, quantity: int):
	if quantity <= 0:
		push_error("Tried to sell %s" % [quantity])
		return

	if !State.Inventory.coins.has(coin_type):
		push_error("Invalid coin type")
		return

	if State.Inventory.coins[coin_type] < quantity:
		push_error("Tried to sell %s but only had %s" % [quantity, State.Inventory.coins[coin_type]])
		return

	var price = State.Market.prices[coin_type].current_price

	State.Inventory.power = State.Inventory.power + (price * quantity)

	var new_coins = State.Inventory.coins[coin_type] - quantity
	State.Inventory.update_coin(coin_type, new_coins)
	
	# Adjust price downward after selling coins
	# Use a non-linear formula: reduction_factor = base_factor * sqrt(quantity)
	var base_factor := 0.01  # 1% reduction per coin as base
	var reduction_factor := base_factor * sqrt(quantity)
	
	# Calculate new price with the reduction
	var new_price := price * (1.0 - reduction_factor)
	
	# Ensure the price doesn't drop below 0.01
	new_price = maxf(new_price, 0.01)
	
	# Update the price, which also emits the price_changed signal
	State.Market.update_price(coin_type, new_price)
