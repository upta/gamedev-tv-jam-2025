extends Mineable

@export var chip_type: Enum.MiningResourceType = Enum.MiningResourceType.BLUE_CHIP

@onready var chip_sprite: AnimatedSprite2D = $ChipSprite
@onready var chip_empty_sprite: Sprite2D = $ChipEmptySprite
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var mined_sfx: AudioStreamPlayer2D = $MinedSFX


func _ready() -> void:
	if chip_type == Enum.MiningResourceType.GREEN_CHIP:
		chip_sprite.play("green")
	elif chip_type == Enum.MiningResourceType.RED_CHIP:
		chip_sprite.play("red")
	elif chip_type == Enum.MiningResourceType.YELLOW_CHIP:
		chip_sprite.play("yellow")
	else:
		chip_sprite.play("blue")


func on_mined():
	collision_shape.disabled = true
	chip_empty_sprite.show()
	State.Inventory.add_mining_resource(chip_type, 1)
	mined_sfx.play()

	chip_sprite.self_modulate.a = 0.75
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel(true)
	tween.tween_property(chip_sprite, "position", Vector2(0, -40), 0.5)
	tween.tween_property(chip_sprite, "modulate", Color.TRANSPARENT, 0.5).set_trans(Tween.TRANS_LINEAR)
	await tween.finished
	chip_sprite.hide()


func on_damaged():
	chip_sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	chip_sprite.modulate = Color.WHITE
