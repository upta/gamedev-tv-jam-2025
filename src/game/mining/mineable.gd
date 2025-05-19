class_name Mineable
extends Node

@export var durability: int = 1


func try_mine(power: int = 1):
	durability -= power
	if durability <= 0:
		on_mined()
	else:
		on_damaged()


func on_damaged():
	pass


func on_mined():
	queue_free()
