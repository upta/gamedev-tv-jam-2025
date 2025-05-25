extends Node2D

@onready var interactable: Interactable = $Interactable
@onready var nope_sfx: AudioStreamPlayer2D = $NopeSFX
@onready var door_sprite: AnimatedSprite2D = $DoorSprite


func _ready():
	interactable.interacted.connect(_on_interacted)
	State.Inventory.power_changed.connect(_on_power_changed)


func _on_interacted():
	if _can_win():
		State.Scene.active_scene = "res://credits/credits.tscn"
	else:
		nope_sfx.play()


func _on_power_changed(_power: float):
	if _can_win():
		door_sprite.play("open")
	else:
		door_sprite.play_backwards("open")


func _can_win() -> bool:
	return State.Inventory.power >= State.Inventory.MAX_POWER
