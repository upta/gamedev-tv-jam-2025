extends Node2D
@onready var chipmonk_sprite = $ChipmonkSprite

func _on_button_pressed():
	print("Button pressed!")
	if Input.is_action_pressed("ui_left"):
		walk_left()
	if Input.is_action_pressed("ui_right"):
		walk_right()
	if Input.is_action_pressed("ui_up"):
		walk_up()
	if Input.is_action_pressed("ui_down"):
		walk_down()


func _input(event):
	if(event is InputEventKey):
		if Input.is_action_pressed("ui_left"):
			walk_left()
		if Input.is_action_pressed("ui_right"):
			walk_right()
		if Input.is_action_pressed("ui_up"):
			walk_up()
		if Input.is_action_pressed("ui_down"):
			walk_down()
		
			
			
func _on_button_released():
	chipmonk_sprite.pause()
	
func walk_right():
	chipmonk_sprite.flip_h = false
	chipmonk_sprite.play("profile")

func walk_up():
	chipmonk_sprite.play("back")

func walk_down():
	chipmonk_sprite.play("front")

func walk_left():
	chipmonk_sprite.flip_h = true
	chipmonk_sprite.play("profile")
