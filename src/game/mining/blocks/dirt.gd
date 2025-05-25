extends Mineable

var dirt_color: Color

@onready var dirt_sprite: AnimatedSprite2D = $DirtSprite
@onready var sfx_mined: AudioStreamPlayer2D = $MinedSFX
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	dirt_sprite.rotate(randi_range(0, 3) * PI / 4)
	_set_frame()


func _set_frame():
	dirt_sprite.frame = clampi(durability - 1, 0, 4)


func on_damaged():
	dirt_sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	dirt_sprite.modulate = Color.WHITE
	_set_frame()


func on_mined():
	sfx_mined.play()
	dirt_sprite.hide()
	collision_shape.disabled = true
