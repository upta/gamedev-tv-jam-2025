class_name EndMining
extends CanvasLayer

@export var chip_labels: Dictionary [Enum.MiningResourceType, Label]


func _on_button_pressed() -> void:
	AudioService.button_select_menu.play()
	State.Scene.active_scene = "res://home_base/home_base.tscn"
	get_tree().paused = false
	await AudioService.button_select_menu.finished


func _on_button_mouse_entered() -> void:
	AudioService.button_mouse_over.play()


func on_time_up():
	get_tree().paused = true
	visible = true

	AudioService.outa_time.play()

	for resource_type in State.Inventory.mining_resources.keys():
		update_chips(resource_type, State.Inventory.mining_resources.get(resource_type, 0))


func update_chips(resource_type: Enum.MiningResourceType, quantity: int):
	chip_labels[resource_type].text = str(quantity)
