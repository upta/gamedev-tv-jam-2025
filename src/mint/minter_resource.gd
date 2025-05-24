class_name MinterResource extends HBoxContainer

@onready var texture_rect: TextureRect = $TextureRect
@onready var quantity_label: Label = $Quantity


func activate(resource: MiningResource, quantity: int) -> void:
	texture_rect.texture = resource.icon
	quantity_label.text = str(quantity)
