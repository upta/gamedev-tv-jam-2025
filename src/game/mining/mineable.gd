class_name Mineable
extends Node2D

@export var durability: int = 1

var is_mined: bool:
	get: return durability <= 0;


func try_mine(power: int = 1) -> bool:
	durability -= power
	if is_mined:
		on_mined()
	else:
		on_damaged()

	# place holder if we add resistance/defence
	# will return false if mine action was not successful
	return true


func on_damaged():
	pass


func on_mined():
	queue_free()
