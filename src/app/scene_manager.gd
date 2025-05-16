extends CanvasItem

@onready var container: Node = %Container
@onready var animation_player: AnimationPlayer = %AnimationPlayer

var active_scene: Node


func _ready() -> void:
	State.Scene.scene_changed.connect(_scene_changed)


func _scene_changed(scene_path: String):
	_load_scene(scene_path)


func _load_scene(scene_path: String):
	if active_scene != null:
		animation_player.play("overlay")
		await animation_player.animation_finished

	if active_scene != null:
		active_scene.queue_free()
		container.remove_child.call_deferred(active_scene)
		await active_scene.tree_exited

	var scene = load(scene_path)
	active_scene = scene.instantiate()
	container.add_child(active_scene)

	animation_player.play_backwards("overlay")
	await animation_player.animation_finished
