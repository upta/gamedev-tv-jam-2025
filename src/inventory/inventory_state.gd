class_name InventoryState extends Node

signal coin_changed(coin_type: Enum.CoinType, quantity: int)
signal power_changed(power: float)
signal mining_resource_changed(resource_type: Enum.MiningResourceType, quantity: int)
signal held_coin_type_changed(old: Enum.CoinType, new: Enum.CoinType)

const MAX_POWER := 1000.00

var coins: Dictionary[Enum.CoinType, int] = {}
# resources represent global inventory resources
var mining_resources: Dictionary[Enum.MiningResourceType, int] = {}

var _held_coin_type: Enum.CoinType = Enum.CoinType.NONE
var held_coin_type: Enum.CoinType:
	get:
		return _held_coin_type
	set(value):
		var old = _held_coin_type
		_held_coin_type = value
		held_coin_type_changed.emit(old, _held_coin_type)

var power := 0.0:
	get:
		return power
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

	out += " - Mining Resources:\n"

	for mining_resource_type in mining_resources.keys():
		out += indent.call("• %s: %d\n" % [ItemTypes.mining_resources[mining_resource_type].name, mining_resources[mining_resource_type]], "   ")

	return out


func add_coin(coin_type: Enum.CoinType, quantity: int):
	var current = coins.get_or_add(coin_type, 0)
	update_coin(coin_type, current + quantity)


func update_coin(coin_type: Enum.CoinType, quantity: int):
	coins[coin_type] = quantity
	coin_changed.emit(coin_type, quantity)


func add_mining_resource(resource_type: Enum.MiningResourceType, quantity: int):
	var current = mining_resources.get_or_add(resource_type, 0)
	update_mining_resource(resource_type, current + quantity)


func update_mining_resource(resource_type: Enum.MiningResourceType, quantity: int):
	mining_resources[resource_type] = quantity
	mining_resource_changed.emit(resource_type, quantity)
