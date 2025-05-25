extends Node2D

@onready var credits_animation: AnimatedSprite2D = $CreditsAnimation


func _ready() -> void:
	await credits_animation.animation_finished
	await get_tree().create_timer(2.0).timeout

	State.Scene.active_scene = "res://main_menu/main_menu.tscn"
