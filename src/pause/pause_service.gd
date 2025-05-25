class_name PauseService extends Node

signal pause_shown;


func show_pause():
	pause_shown.emit()
