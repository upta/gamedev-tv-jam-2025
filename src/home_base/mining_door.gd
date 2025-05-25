extends Node2D

@onready var interactable: Interactable = $Interactable


func _ready():
	interactable.interacted.connect(_on_interacted)


func _on_interacted():
	State.Scene.active_scene = "res://game/mining_area.tscn"
	AudioService.game_music_home.stop()
