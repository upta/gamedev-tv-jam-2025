extends Node2D

@export var type: Enum.UpgradeType
@export var upgrade_summary: UpgradeSummary

@onready var icon: Sprite2D = $Icon
@onready var interactable: Interactable = $Interactable


func _ready() -> void:
	icon.texture = ItemTypes.upgrades[type].icon

	interactable.interacted.connect(_on_interacted)
	interactable.can_interact_changed.connect(_on_interact_change)


func _on_interact_change(_interactable: bool):
	if _interactable:
		upgrade_summary.show_summary(type)
	else:
		upgrade_summary.clear_summary()


func _on_interacted():
	var available_power = State.Inventory.power
	var current_level = State.Upgrade.get_level(type)
	var item = ItemTypes.upgrades[type]
	if item.can_upgrade_to(current_level + 1) and available_power >= item.get_upgrade_cost(current_level + 1):
		State.Upgrade.set_level(type, current_level + 1)
		State.Inventory.power -= item.get_upgrade_cost(current_level + 1)
		upgrade_summary.show_summary(type)
		$PowerUpSFX.play()
	else:
		$NopeSFX.play()
