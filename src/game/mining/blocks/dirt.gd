extends Mineable

var dirt_color: Color

@onready var dirt_sprite: Sprite2D = $DirtSprite
@onready var sfx_mined: AudioStreamPlayer2D = $MinedSFX
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	var color_val = 1 - (durability - 1) * 0.2
	dirt_color = Color(color_val, color_val, color_val)
	dirt_sprite.modulate = dirt_color


func on_damaged():
	dirt_sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	dirt_sprite.modulate = dirt_color


func on_mined():
	sfx_mined.play()
	dirt_sprite.hide()
	collision_shape.disabled = true
