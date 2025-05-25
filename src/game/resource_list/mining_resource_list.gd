extends PanelContainer

@export var list_item_scene: PackedScene

@onready var container: VBoxContainer = $Container


func _ready() -> void:
	for child in container.get_children():
		child.queue_free()

	for resource_type in ItemTypes.mining_resources.keys():
		var instance = list_item_scene.instantiate() as MiningResourceListItem
		container.add_child(instance)
		instance.activate(resource_type)
