class_name EndMining
extends CanvasLayer

@export var chip_labels: Dictionary [Enum.MiningResourceType, Label]

@onready var out_of_time_sfx: AudioStreamPlayer = $SFX/OutaTime


func _on_button_pressed() -> void:
	State.Scene.active_scene = "res://main_menu/main_menu.tscn"
	get_tree().paused = false


func on_time_up():
	get_tree().paused = true
	visible = true

	out_of_time_sfx.play()

	var chip_resources = State.Inventory.get_all_staged_mining_resources()
	chip_resources.get(Enum.MiningResourceType.BLUE_CHIP, 0)

	Service.Inventory.bank_staged_mining_resources()


func update_chips(resource_type: Enum.MiningResourceType, quantity: int):
	chip_labels[resource_type].text = str(quantity)
