extends UpgradeResource

@export var cost_base: int;
@export var cost_growth: float;
@export var time_increment: int;
@export var base_time: int;


func get_upgrade_keys() -> Array[String]:
	return ["time"]


func can_upgrade_to(level: int) -> bool:
	return true


func get_upgrade_value(key: String, level: int) -> float:
	if key == "time":
		return base_time + time_increment * level

	return 0


func get_upgrade_cost(level: int) -> int:
	return roundi((cost_base + cost_growth * (level - 1)) * level)


func get_key_name(key: String) -> String:
	if key == "time":
		return "Time"

	return ""
