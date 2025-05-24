class_name InventoryService extends Node


func add_coins(coin_type: Enum.CoinType, quantity: int):
	State.Inventory.add_coin(coin_type, quantity)


func add_staged_mining_resources(resource_type: Enum.MiningResourceType, quantity: int):
	State.Inventory.add_staged_mining_resource(resource_type, quantity)


func bank_staged_mining_resources():
	var staged = State.Inventory.get_all_staged_mining_resources()
	for resource in staged:
		State.Inventory.add_mining_resource(resource, staged[resource])
		State.Inventory.update_staged_mining_resource(resource, 0)


func pick_up_coin(coin_type: Enum.CoinType):
	if State.Inventory.held_coin_type == Enum.CoinType.NONE:
		State.Inventory.held_coin_type = coin_type


func return_coin():
	State.Inventory.held_coin_type = Enum.CoinType.NONE


func has_held_coin() -> bool:
	return State.Inventory.held_coin_type != Enum.CoinType.NONE
