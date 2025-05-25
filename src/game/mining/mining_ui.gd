class_name MiningUI
extends CanvasLayer

@export var time_left_label: Label

@export var bomb_action_indicator: ActionIndicator


func set_time_left(time: float):
	time_left_label.text = "Time left: " + str(ceili(time))


func set_bomb_action_time(time: float):
	bomb_action_indicator.set_time_left(time)
