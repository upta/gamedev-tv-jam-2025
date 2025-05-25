class_name MiningResourceListItem extends HBoxContainer

var resource_type: Enum.MiningResourceType

@onready var icon: TextureRect = %Icon
@onready var label: Label = %Label


func _ready() -> void:
	State.Inventory.mining_resource_changed.connect(_on_mining_resource_changed)


func _on_mining_resource_changed(_resource_type: Enum.MiningResourceType, quantity: int):
	if resource_type == _resource_type:
		label.text = str(quantity)


func activate(_mining_resource_type: Enum.MiningResourceType):
	resource_type = _mining_resource_type

	var resource = ItemTypes.mining_resources[resource_type]
	icon.texture = resource.icon
	label.text = str(State.Inventory.mining_resources.get(resource_type, 0))
