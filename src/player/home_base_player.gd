class_name HomeBasePlayer extends Player

@onready var interactable: Interactable = %Interactable
@onready var interaction_hint: PanelContainer = $InteractionHint


func _ready() -> void:
	interaction_hint.visible = false
	interactable.can_interact_changed.connect(_on_can_interact_changed)


func _on_can_interact_changed(can_interact: bool):
	interaction_hint.visible = can_interact
