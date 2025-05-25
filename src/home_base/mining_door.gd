extends Node2D

@onready var interactable: Interactable = $Interactable


func _ready():
	interactable.interacted.connect(_on_interacted)


func _on_interacted():
	for resource_type in ItemTypes.mining_resources:
		var remaining = State.Inventory.mining_resources.get(resource_type, 0)
		for i in range(0, remaining):
			Service.Inventory.refund_resource(resource_type)
			await get_tree().create_timer(0.25).timeout

	State.Scene.active_scene = "res://game/mining_area.tscn"
	AudioService.game_music_home.stop()
