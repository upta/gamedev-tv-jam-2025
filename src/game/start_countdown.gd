extends CanvasLayer

signal on_countdown_finished()

@export var main_context: GUIDEMappingContext
@export var tutorial_context: GUIDEMappingContext
@export var tutorial_next: GUIDEAction

@export var countdown_time: int = 3

var elapsed_time: float = 0

@onready var last_countdown_number: int = countdown_time + 1


func _ready() -> void:
	pause_game.call_deferred()
	tutorial_next.triggered.connect(_on_tutorial_next_triggered)


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


func _on_tutorial_next_triggered():
	%ContinueButton.pressed.emit()


func pause_game():
	get_tree().paused = true


func end_countdown():
	$CountdownLabel.hide()
	if State.Tutorial.should_show_mining_tutorial:
		State.Tutorial.should_show_mining_tutorial = false

		%ContinueButton.grab_focus()
		Service.Guide.set_local_context(tutorial_context)

		$Tutorial.show()
		await %ContinueButton.pressed

		Service.Guide.set_local_context.call_deferred(main_context)
	else:
		Service.Guide.set_local_context.call_deferred(main_context)

	get_tree().paused = false
	hide()
	AudioService.beep_high.play()
	on_countdown_finished.emit()
	await AudioService.beep_high.finished
	queue_free()
