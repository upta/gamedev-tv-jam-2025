extends Node

@export var coins: Dictionary[Enum.CoinType, CoinResource] = {}
@export var mining_resources: Dictionary[Enum.MiningResourceType, MiningResource] = {}
@export var recipes: Dictionary[Enum.CoinType, RecipeResource] = {}
