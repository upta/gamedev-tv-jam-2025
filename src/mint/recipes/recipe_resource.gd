class_name RecipeResource extends Resource

@export var coin: CoinResource
@export var resources: Dictionary[MiningResource, int] = {}


func _to_string() -> String:
	var resource_string = ""
	for resource in resources:
		resource_string += "\n  - %s x%d" % [resource.name, resources[resource]]

	return "RecipeResource(coin: %s, resources: %s)" % [coin.name, resource_string]
