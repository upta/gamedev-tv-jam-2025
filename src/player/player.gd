extends CharacterBody2D

@export var move_action: GUIDEAction
@export var speed: float = 300.0

var input_direction: Vector2
var facing_direction: Enum.Direction = Enum.Direction.SOUTH

@onready var sprite_animation: AnimatedSprite2D = $SpriteAnimation


func _ready() -> void:
	play_idle()


func _physics_process(_delta: float) -> void:
	input_direction = move_action.value_axis_2d

	if input_direction == Vector2.ZERO:
		velocity = input_direction
		play_idle()
	else:
		input_direction = input_direction.normalized()
		velocity = input_direction * speed

		if abs(input_direction.x) > abs(input_direction.y):
			facing_direction = Enum.Direction.WEST if input_direction.x < 0 else Enum.Direction.EAST
		else:
			facing_direction = Enum.Direction.NORTH if input_direction.y < 0 else Enum.Direction.SOUTH

		play_walk()

	move_and_slide()


func play_idle():
	sprite_animation.play("idle_" + Enum.direction_as_string(facing_direction))


func play_walk():
	sprite_animation.play("walk_" + Enum.direction_as_string(facing_direction))
