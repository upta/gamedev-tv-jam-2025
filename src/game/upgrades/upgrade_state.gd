class_name UpgradeState extends Node

var upgrade_level: Dictionary[Enum.UpgradeType, int] = {}


func set_level(type: Enum.UpgradeType, level: int):
	upgrade_level[type] = level


func get_level(type: Enum.UpgradeType) -> int:
	return upgrade_level.get(type, 0)
