class_name MiningUI
extends CanvasLayer

@export var chip_labels: Dictionary [Enum.MiningResourceType, Label]
@export var time_left_label: Label

@export var bomb_action_indicator: ActionIndicator


func _ready():
	State.Inventory.staged_mining_resource_changed.connect(
		update_chips
	)


func update_chips(resource_type: Enum.MiningResourceType, quantity: int):
	chip_labels[resource_type].text = str(quantity)


func set_time_left(time: float):
	time_left_label.text = "Time left: " + str(ceili(time))


func set_bomb_action_time(time: float):
	bomb_action_indicator.set_time_left(time)
