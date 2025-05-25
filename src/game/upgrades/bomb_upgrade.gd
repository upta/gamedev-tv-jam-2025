extends UpgradeResource

@export var max_levels: int
@export var cost_base: int
@export var cost_growth: float
@export var base_strength: int
@export var min_cooldown: float
@export var strength_growth: float
@export var base_cooldown: float
@export var cooldown_shrink: float
@export var max_strength: int
@export var base_radius: int
@export var max_radius: int
@export var radius_growth: float


func get_upgrade_keys() -> Array[String]:
	return ["cooldown", "strength", "radius"]


func can_upgrade_to(level: int) -> bool:
	return level <= max_levels


func get_upgrade_value(key: String, level: int) -> float:
	if key == "cooldown":
		return max(base_cooldown - cooldown_shrink * level, min_cooldown)
	if key == "strength":
		return min(base_strength + floori(level * strength_growth), max_strength)
	if key == "radius":
		return min(base_radius + floori(level * radius_growth), max_radius)

	return 0


func get_upgrade_cost(level: int) -> int:
	return roundi((cost_base + cost_growth * (level - 1)) * level)


func get_key_name(key: String) -> String:
	if key == "cooldown":
		return "Cooldown"
	if key == "strength":
		return "Strength"
	if key == "radius":
		return "Radius"

	return ""
