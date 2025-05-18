class_name CoinResource extends Resource

@export var base_price: float = 0.0
@export var icon: Texture2D
@export var name: String
@export var type: Enum.CoinType


func _to_string() -> String:
	return "CoinResource(name: %s, type: %s, base_price: %.2f)" % [
		name, str(type), base_price
	]
