class_name InventoryService extends Node


func add_coins(coin_type: Enum.CoinType, quantity: int):
	State.Inventory.add_coin(coin_type, quantity)


func pick_up_coin(coin_type: Enum.CoinType):
	if State.Inventory.held_coin_type == Enum.CoinType.NONE:
		State.Inventory.held_coin_type = coin_type


func refund_resource(resource_type: Enum.MiningResourceType):
	if not State.Inventory.mining_resources.has(resource_type):
		push_error("Doesn't have resource %" % resource_type)
		return

	var current_resource_count = State.Inventory.mining_resources.get(resource_type)

	State.Inventory.update_mining_resource(resource_type, current_resource_count - 1)
	State.Inventory.power = State.Inventory.power + 1.0


func return_coin():
	State.Inventory.held_coin_type = Enum.CoinType.NONE


func has_held_coin() -> bool:
	return State.Inventory.held_coin_type != Enum.CoinType.NONE
