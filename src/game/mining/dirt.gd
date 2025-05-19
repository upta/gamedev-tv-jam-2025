extends Mineable

@onready var base_color = $ColorRect.color


func on_damaged():
	$ColorRect.color = Color.RED
	await get_tree().create_timer(0.1).timeout
	$ColorRect.color = base_color
