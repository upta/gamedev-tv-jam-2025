extends AnimatedSprite2D

@onready var current_power: Label = %CurrentPower


func _ready():
	State.Inventory.power_changed.connect(_on_power_changed)
	_on_power_changed(State.Inventory.power)


func _on_power_changed(power: float):
	# Calculate ratio (0 to 1)
	var ratio = power / State.Inventory.MAX_POWER

	#Clamp to valid range
	ratio = clamp(ratio, 0.0, 1.0)

	#Round to nearest 10 %
	var rounded_ratio = floori(ratio * 10.0) * 10

	play(str(rounded_ratio))

	current_power.text = "%d" % power
