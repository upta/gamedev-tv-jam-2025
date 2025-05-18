class_name InventoryService extends Node


func add_coins(coin_type: Enum.CoinType, quantity: int):
	State.Inventory.add_coin(coin_type, quantity)
