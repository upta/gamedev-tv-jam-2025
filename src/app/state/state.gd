extends Node

var Inventory := InventoryState.new()
var Market := MarketState.new()
var Scene := StateScene.new()


func _enter_tree() -> void:
	add_child(Inventory)
	add_child(Market)
	add_child(Scene)
