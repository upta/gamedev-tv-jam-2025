class_name ActionIndicator
extends Control

@export var icon: CompressedTexture2D
@export var hot_key: String


func _ready() -> void:
	$Icon.texture = icon
	$KeyLabel.text = hot_key


func set_time_left(time: float):
	if time > 0:
		$Icon.self_modulate.a = 0.5
		$KeyLabel.hide()
		$CountDownLabel.show()
		$CountDownLabel.text = str(ceili(time))
	else:
		$Icon.self_modulate.a = 1
		$CountDownLabel.hide()
		$KeyLabel.show()
