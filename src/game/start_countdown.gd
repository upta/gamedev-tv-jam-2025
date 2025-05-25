extends CanvasLayer

@export var countdown_time: int = 3

signal on_countdown_finished()

var elapsed_time: float = 0

@onready var last_countdown_number: int = countdown_time + 1


func _ready() -> void:
	pause_game.call_deferred()


func _process(delta: float) -> void:
	elapsed_time += delta
	var time_left = ceili(countdown_time - elapsed_time)
	$CountdownLabel.text = str(time_left)

	if time_left > 0:
		if last_countdown_number != time_left:
			last_countdown_number = time_left
			AudioService.beep_low.play()
	else:
		if last_countdown_number > 0:
			last_countdown_number = 0
			end_countdown()


func pause_game():
	get_tree().paused = true


func end_countdown():
	$CountdownLabel.hide()
	if State.Tutorial.should_show_mining_tutorial:
		State.Tutorial.should_show_mining_tutorial = false
		$Tutorial.show()
		await %ContinueButton.pressed

	get_tree().paused = false
	hide()
	AudioService.beep_high.play()
	on_countdown_finished.emit()
	await AudioService.beep_high.finished
	queue_free()
