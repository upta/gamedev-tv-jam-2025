class_name IngredientDisplay extends HBoxContainer

@onready var icon: TextureRect = %Icon
@onready var quantity: Label = %Quantity


func activate(_resource: MiningResource, _quantity: int):
	icon.texture = _resource.icon
	quantity.text = str(_quantity)
