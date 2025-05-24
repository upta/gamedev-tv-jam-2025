extends Node2D

@onready var interactable: Interactable = $Interactable
@onready var highlight_animation: AnimationPlayer = $HighlightAnimation


func _ready() -> void:
	interactable.interacted.connect(_on_interacted)
	State.Inventory.held_coin_type_changed.connect(_on_held_coin_type_changed)


func _on_interacted():
	if Service.Inventory.has_held_coin():
		var type = State.Inventory.held_coin_type
		var count = State.Inventory.coins.get(type, 0)

		Service.Market.sell_coins(type, count)
		Service.Inventory.return_coin()


func _on_held_coin_type_changed(_old: Enum.CoinType, _new: Enum.CoinType):
	if Service.Inventory.has_held_coin():
		highlight_animation.play("fade")
	else:
		highlight_animation.play_backwards("fade")
