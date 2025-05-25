extends UpgradeResource

@export var cost_base: int
@export var cost_growth: float
@export var base_speed: int
@export var speed_increment: int
@export var max_level: int


func get_upgrade_keys() -> Array[String]:
	return ["speed"]


func can_upgrade_to(level: int) -> bool:
	return level <= max_level


func get_upgrade_value(key: String, level: int) -> float:
	if key == "speed":
		return base_speed + speed_increment * level

	return 0


func get_upgrade_cost(level: int) -> int:
	return roundi((cost_base + cost_growth * (level - 1)) * level)


func get_key_name(key: String) -> String:
	if key == "speed":
		return "Speed"

	return ""
