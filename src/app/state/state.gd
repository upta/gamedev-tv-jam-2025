extends Node

var Inventory := InventoryState.new()
var Market := MarketState.new()
var Scene := StateScene.new()
var Upgrade := UpgradeState.new()
var Tutorial := TutorialState.new()


func _enter_tree() -> void:
	add_child(Inventory)
	add_child(Market)
	add_child(Scene)
	add_child(Upgrade)
	add_child(Tutorial)
