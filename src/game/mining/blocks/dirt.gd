extends Mineable

@onready var dirt_sprite: Sprite2D = $DirtSprite
@onready var sfx_mined: AudioStreamPlayer2D = $MinedSFX
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func on_damaged():
	dirt_sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	dirt_sprite.modulate = Color.WHITE


func on_mined():
	sfx_mined.play()
	dirt_sprite.hide()
	collision_shape.disabled = true
