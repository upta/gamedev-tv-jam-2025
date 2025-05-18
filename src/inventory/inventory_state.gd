class_name InventoryState extends Node

signal coin_changed(coin_type: Enum.CoinType, quantity: int)
signal power_changed(power: float)

var coins: Dictionary[Enum.CoinType, int] = {}

var power := 0.0:
	get: return power
	set(value):
		power = value
		power_changed.emit(power)


func _to_string() -> String:
	var indent := func(text: String, prefix: String) -> String:
		return "\n".join(Array(text.split("\n")).map(func(line): return prefix + line))

	var out := "InventoryState:\n"
	out += " - Power: %.2f\n" % power
	out += " - Coins:\n"

	for coin_type in coins.keys():
		out += indent.call("• %s: %d\n" % [ItemTypes.coins[coin_type].name, coins[coin_type]], "   ")

	return out


func add_coin(coin_type: Enum.CoinType, quantity: int):
	var current = coins.get_or_add(coin_type, 0)
	update_coin(coin_type, current + quantity)


func update_coin(coin_type: Enum.CoinType, quantity: int):
	coins[coin_type] = quantity
	coin_changed.emit(coin_type, quantity)
