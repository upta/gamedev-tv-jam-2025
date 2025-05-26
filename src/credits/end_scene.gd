extends Node2D

@onready var animation: AnimatedSprite2D = $Animation


func _ready() -> void:
	await animation.animation_finished
	await get_tree().create_timer(2.0).timeout

	State.Scene.active_scene = "res://credits/credits.tscn"
