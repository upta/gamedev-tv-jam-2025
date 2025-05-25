extends PanelContainer

@export var market_price_line_item_scene: PackedScene

@onready var container: VBoxContainer = %Container


func _ready() -> void:
	for child in container.get_children():
		child.queue_free()

	for coin in ItemTypes.coins.values():
		var instance := market_price_line_item_scene.instantiate() as MarketPriceLineItem
		container.add_child(instance)
		instance.activate(coin)
