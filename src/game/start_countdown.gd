extends CanvasLayer

@export var countdown_time: int = 3

signal on_countdown_finished()

var elapsed_time: float = 0

@onready var last_countdown_number: int = countdown_time + 1
@onready var beep_low_sfx: AudioStreamPlayer = $SFX/LowBeep
@onready var beep_high_sfx: AudioStreamPlayer = $SFX/HighBeep


func _ready() -> void:
	pause_game.call_deferred()


func _process(delta: float) -> void:
	elapsed_time += delta
	var time_left = ceili(countdown_time - elapsed_time)
	$"Countdown Label".text = str(time_left)

	if time_left > 0:
		if last_countdown_number != time_left:
			last_countdown_number = time_left
			beep_low_sfx.play()
	else:
		if last_countdown_number > 0:
			last_countdown_number = 0
			end_countdown()


func pause_game():
	get_tree().paused = true


func end_countdown():
	get_tree().paused = false
	hide()
	beep_high_sfx.play()
	on_countdown_finished.emit()
	await beep_high_sfx.finished
	queue_free()
