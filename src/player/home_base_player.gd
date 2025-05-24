class_name HomeBasePlayer extends Player

@onready var interactable: Interactable = %Interactable
@onready var interaction_hint: PanelContainer = $InteractionHint
@onready var held_coin: Sprite2D = %HeldCoin


func _ready() -> void:
	interaction_hint.visible = false
	_update_held_coin()

	interactable.can_interact_changed.connect(_on_can_interact_changed)
	State.Inventory.held_coin_type_changed.connect(_on_held_coin_type_changed)


func _on_can_interact_changed(can_interact: bool):
	interaction_hint.visible = can_interact


func _on_held_coin_type_changed(_old: Enum.CoinType, _new: Enum.CoinType):
	_update_held_coin()


func _update_held_coin():
	if Service.Inventory.has_held_coin():
		held_coin.visible = true
		var coin = ItemTypes.coins[State.Inventory.held_coin_type]
		held_coin.texture = coin.icon
	else:
		held_coin.visible = false
