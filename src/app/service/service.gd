extends Node

# gdlint: disable=class-variable-name
var Inventory := InventoryService.new()
var Market := MarketService.new()
var Mint := MintService.new()
var Upgrade := UpgradeService.new()

# gdlint: enable=class-variable-name


func _ready() -> void:
	add_child(Inventory)
	add_child(Market)
	add_child(Mint)
	add_child(Upgrade)
