extends UpgradeResource

@export var cost_base: int
@export var cost_growth: float
@export var strength_increment: int
@export var base_strength: int
@export var max_strength: int


func get_upgrade_keys() -> Array[String]:
	return ["strength"]


func can_upgrade_to(level: int) -> bool:
	return get_upgrade_value("strength", level) <= max_strength


func get_upgrade_value(key: String, level: int) -> float:
	if key == "strength":
		return base_strength + strength_increment * level

	return 0


func get_upgrade_cost(level: int) -> int:
	return roundi((cost_base + cost_growth * (level - 1)) * level)


func get_key_name(key: String) -> String:
	if key == "strength":
		return "Strength"

	return ""
