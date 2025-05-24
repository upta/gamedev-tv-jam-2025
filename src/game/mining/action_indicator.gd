class_name ActionIndicator
extends Control

@export var icon: CompressedTexture2D


func _ready() -> void:
	$Icon.texture = icon


func set_time_left(time: float):
	if time > 0:
		$Icon.self_modulate.a = 0.5
		$Label.show()
		$Label.text = str(ceili(time))
	else:
		$Icon.self_modulate.a = 1
		$Label.hide()
