extends Node

var Market := MarketService.new()


func _ready() -> void:
	add_child(Market)
