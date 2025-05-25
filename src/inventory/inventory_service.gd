class_name InventoryService extends Node


func add_coins(coin_type: Enum.CoinType, quantity: int):
	State.Inventory.add_coin(coin_type, quantity)


func pick_up_coin(coin_type: Enum.CoinType):
	if State.Inventory.held_coin_type == Enum.CoinType.NONE:
		State.Inventory.held_coin_type = coin_type


func return_coin():
	State.Inventory.held_coin_type = Enum.CoinType.NONE


func has_held_coin() -> bool:
	return State.Inventory.held_coin_type != Enum.CoinType.NONE
