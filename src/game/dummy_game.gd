extends Control

@export var input_context: GUIDEMappingContext


func _ready():
	GUIDE.enable_mapping_context(input_context, true)
