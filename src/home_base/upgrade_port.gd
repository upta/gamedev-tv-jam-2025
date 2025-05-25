extends Node2D

@export var type: Enum.UpgradeType

@onready var icon: Sprite2D = $Icon
@onready var interactable: Interactable = $Interactable


func _ready() -> void:
	icon.texture = ItemTypes.upgrades[type].icon

	interactable.interacted.connect(_on_interacted)


func _on_interacted():
	prints("Interacted")
