extends Mineable

@onready var dirt_sprite = $DirtSprite


func on_damaged():
	dirt_sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	dirt_sprite.modulate = Color.WHITE
