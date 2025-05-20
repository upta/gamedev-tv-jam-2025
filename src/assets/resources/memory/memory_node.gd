extends Node2D
@onready var memory_sprite = $MemorySprite



	
func _input(event):
	if(event is InputEventKey):
		print("Button pressed!")
		if Input.is_action_pressed("ui_left"):
			random_node()
		if Input.is_action_pressed("ui_right"):
			random_node()
		if Input.is_action_pressed("ui_up"):
			remove_node()
		if Input.is_action_pressed("ui_down"):
			blank_node()

func random_node():
	#get random 1->4 play animation 
	memory_sprite.play("chip_randomize")
	# wait 1 second
	#set
	var random_interger = randi() %4
	await get_tree().create_timer(2).timeout
	match random_interger:
		0:
			memory_sprite.play("chip_blue")
		1:
			memory_sprite.play("chip_green")
		2:
			memory_sprite.play("chip_red")
		3:
			memory_sprite.play("chip_yellow")
	
	
func remove_node():
	memory_sprite.play("chip_empty")

func blank_node():
	memory_sprite.play("chip_blank")
	
