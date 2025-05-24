class_name UpgradeResource extends Resource

@export var name: String
@export var icon: Texture2D
@export var type: Enum.UpgradeType


func get_upgrade_keys() -> Array[String]:
	return []


func can_upgrade_to(level: int) -> bool:
	return false


func get_upgrade_value(key: String, level: int) -> float:
	return 0.0


func get_upgrade_cost(level: int) -> int:
	return 0


func get_key_name(key: String) -> String:
	return ""
