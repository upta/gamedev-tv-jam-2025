class_name MiningResource extends Resource

@export var name: String
@export var icon: Texture2D
@export var type: Enum.MiningResourceType


func _to_string() -> String:
	return "MiningResourceType(name: %s, type: %s)" % [
		name, str(type)
	]
