extends Node

var Inventory := InventoryService.new()
var Market := MarketService.new()


func _ready() -> void:
	add_child(Inventory)
	add_child(Market)
