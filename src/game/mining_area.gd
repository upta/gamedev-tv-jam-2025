extends Node2D

@export var input_context: GUIDEMappingContext
@export var total_mining_time: float = 60.0

@onready var time_elapsed: float = 0.0
@onready var time_left: float = total_mining_time


func _ready():
	GUIDE.enable_mapping_context(input_context, true)

	# TODO - this is just a temporary test - we will rework the UI code
	State.Inventory.staged_mining_resource_changed.connect(
		func(resource_type: Enum.MiningResourceType, quantity: int):
		if resource_type == Enum.MiningResourceType.BLUE_CHIP:
			get_node("CanvasLayer/PanelContainer/MarginContainer/GridContainer/ChipBlue Label").text = str(quantity)
	)


func _process(delta: float) -> void:
	time_elapsed += delta
	time_left = max(total_mining_time - time_elapsed, 0)

	# temp - set time left
	%TimeLeftLabel.text = "Time left: %.0f" % time_left

	if time_left <= 0:
		_end_mining()


func _end_mining() -> void:
	# todo - actually do something when ending mining session
	get_tree().paused = true
