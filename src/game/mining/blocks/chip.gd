extends Mineable

@onready var chip_sprite: AnimatedSprite2D = $ChipSprite
@onready var chip_empty_sprite: Sprite2D = $ChipEmptySprite
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func on_mined():
	collision_shape.disabled = true
	chip_sprite.hide()
	chip_empty_sprite.show()
	Service.Inventory.add_staged_mining_resources(Enum.MiningResourceType.BLUE_CHIP, 1)


func on_damaged():
	chip_sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	chip_sprite.modulate = Color.WHITE
