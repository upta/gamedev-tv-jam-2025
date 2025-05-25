class_name MiningUI
extends CanvasLayer

@export var time_left_label: Label

@export var bomb_action_indicator: ActionIndicator

var last_time_left: int


func set_time_left(time: int):
	if time < 10 and last_time_left != time:
		last_time_left = time
		$TimingOutSFX.play()
		time_left_label.add_theme_color_override("font_color", Color.RED)

	time_left_label.text = "Time left: " + str(time)


func set_bomb_action_time(time: float):
	bomb_action_indicator.set_time_left(time)
