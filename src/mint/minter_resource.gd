class_name MinterResource extends HBoxContainer

var resource: MiningResource
var cost: int

@onready var texture_rect: TextureRect = $TextureRect
@onready var x_label: Label = %X
@onready var quantity_label: Label = $Quantity


func _on_mining_resource_changed(resource_type: Enum.MiningResourceType, quantity: int):
	if resource.type != resource_type:
		return

	var color = Color.WHITE if quantity >= cost else Color.RED

	x_label.modulate = color
	quantity_label.modulate = color


func activate(_resource: MiningResource, _cost: int) -> void:
	State.Inventory.mining_resource_changed.connect(_on_mining_resource_changed)

	resource = _resource
	cost = _cost
	texture_rect.texture = resource.icon
	quantity_label.text = str(_cost)

	_on_mining_resource_changed(_resource.type, _cost)
