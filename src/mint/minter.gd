extends Node2D

@export var coin_type: Enum.CoinType

@onready var ingredients: HBoxContainer = %Ingredients

#func _ready() -> void:
	## Look up the recipe for the coin
	#var recipe = Service.Mint.get_recipe_for_coin(coin_type)
	#if not recipe:
		#push_error("Recipe not found for coin type: %s" % coin_type)
		#return
	#
	## Create a new MinterResource for each ingredient
	#for resource in recipe.resources:
		#var quantity = recipe.resources[resource]
		#
		## Create the minter resource node
		#var minter_resource = preload("res://mint/minter_resource.tscn").instantiate()
		#
		## Add it to the ingredients container
		#ingredients.add_child(minter_resource)
		#
		## Activate the node after it's been added
		#minter_resource.activate(resource, quantity)
