class_name MintService extends Node


# Get the recipe for a specific coin type
func get_recipe_for_coin(coin_type: Enum.CoinType) -> RecipeResource:
	if ItemTypes.recipes.has(coin_type):
		return ItemTypes.recipes[coin_type]

	push_error("Recipe not found for coin type: %s" % coin_type)
	return null


# Get the recipe for a specific coin resource
func get_recipe_for_coin_resource(coin: CoinResource) -> RecipeResource:
	if coin:
		return get_recipe_for_coin(coin.type)

	push_error("Cannot get recipe: coin resource is null")
	return null


# Calculate the maximum number of coins that can be crafted based on available resources
func calculate_max_craftable_quantity(recipe: RecipeResource) -> int:
	var max_craftable = 999999 # Start with a high number

	for resource in recipe.resources:
		var required_per_craft = recipe.resources[resource]
		var available = State.Inventory.mining_resources.get(resource.type, 0)

		# Can't craft any if a required resource is missing
		if required_per_craft > 0 and available == 0:
			return 0

		# Calculate how many we can craft with this resource
		var craftable_with_resource = available / required_per_craft

		# Update max_craftable if this resource is more limiting
		max_craftable = min(max_craftable, craftable_with_resource)

	return max_craftable


# Check if a specific coin type can be crafted based on available resources
# Returns true if at least one coin can be crafted
func can_craft(coin_type: Enum.CoinType) -> bool:
	var recipe = get_recipe_for_coin(coin_type)
	if not recipe:
		push_error("Cannot check craftability: recipe not found for coin type")
		return false

	return calculate_max_craftable_quantity(recipe) > 0


# Attempt to mint a specific quantity of coins
# Returns true if successful, false if not enough resources
func mint_coin(coin_type: Enum.CoinType, amount: int) -> bool:
	var recipe = get_recipe_for_coin(coin_type)
	if not recipe:
		push_error("Cannot mint: recipe not found for coin type")
		return false

	# Check if we have enough resources
	var can_mint = true
	for resource in recipe.resources:
		var required_amount = recipe.resources[resource] * amount
		var available_amount = State.Inventory.mining_resources.get(resource.type, 0)

		if available_amount < required_amount:
			can_mint = false
			break

	# If we have enough resources, deduct them and add the coins
	if can_mint:
		for resource in recipe.resources:
			var required_amount = recipe.resources[resource] * amount
			var current_amount = State.Inventory.mining_resources.get(resource.type, 0)
			State.Inventory.update_mining_resource(resource.type, current_amount - required_amount)

		Service.Inventory.add_coins(coin_type, amount)
		return true

	push_error("Cannot mint coin: Not enough resources")
	return false
