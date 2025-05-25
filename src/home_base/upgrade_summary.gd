class_name UpgradeSummary extends PanelContainer

@onready var default_label := %DefaultLabel
@onready var name_label = %NameLabel
@onready var cost_label = %CostLabel
@onready var spec_label = %SpecLabel
@onready var power_warning_label = %PowerWarningLabel


func show_summary(of: Enum.UpgradeType):
	default_label.hide()

	var available_power = State.Inventory.power
	var current_level = State.Upgrade.get_level(of)
	var item = ItemTypes.upgrades[of]

	var is_max_level = not item.can_upgrade_to(current_level + 1)

	if not is_max_level:
		name_label.text = ("%s - lvl %d" % [item.name, current_level])
	else:
		name_label.text = ("%s - lvl max" % item.name)
	name_label.show()

	if not is_max_level:
		var cost = item.get_upgrade_cost(current_level + 1)
		cost_label.text = ("Cost: %d power" % cost)
		if available_power < cost:
			power_warning_label.show()
		cost_label.show()

	spec_label.text = ""
	for key in item.get_upgrade_keys():
		spec_label.text += "%s: %d" % [item.get_key_name(key), item.get_upgrade_value(key, current_level)]
		if not is_max_level:
			spec_label.text += " -> %d" % item.get_upgrade_value(key, current_level + 1)
	spec_label.show()


func clear_summary():
	default_label.show()
	name_label.hide()
	cost_label.hide()
	spec_label.hide()
	power_warning_label.hide()
