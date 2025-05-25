class_name UpgradeService extends Node


func get_upgrade_value(type: Enum.UpgradeType, key: String) -> float:
	var level = State.Upgrade.get_level(type)
	return ItemTypes.upgrades[type].get_upgrade_value(key, level)
