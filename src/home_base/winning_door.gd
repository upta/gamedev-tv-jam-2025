extends Node2D

var previous_can_win := false

@onready var interactable: Interactable = $Interactable
@onready var nope_sfx: AudioStreamPlayer2D = $NopeSFX
@onready var door_sprite: AnimatedSprite2D = $DoorSprite


func _ready():
	interactable.interacted.connect(_on_interacted)
	State.Inventory.power_changed.connect(_on_power_changed)

	await get_tree().create_timer(2).timeout

	State.Inventory.power = 10000

	await get_tree().create_timer(2).timeout

	State.Inventory.power = 50


func _on_interacted():
	if _can_win():
		State.Scene.active_scene = "res://credits/credits.tscn"
	else:
		nope_sfx.play()


func _on_power_changed(_power: float):
	if _can_win() == previous_can_win:
		return

	previous_can_win = _can_win()

	if _can_win():
		door_sprite.play("open")
	else:
		door_sprite.play_backwards("open")


func _can_win() -> bool:
	return State.Inventory.power >= State.Inventory.MAX_POWER
