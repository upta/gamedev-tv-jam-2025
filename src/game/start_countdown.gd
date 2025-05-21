extends CanvasLayer

@export var countdown_time: int = 3

var elapsed_time: float = 0


func _ready() -> void:
	pause_game.call_deferred()


func _process(delta: float) -> void:
	elapsed_time += delta
	var time_left = ceili(countdown_time - elapsed_time)
	$"Countdown Label".text = str(time_left)

	if time_left <= 0:
		end_countdown()


func pause_game():
	get_tree().paused = true


func end_countdown():
	queue_free()
	get_tree().paused = false
