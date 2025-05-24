class_name CoinList extends Control

@onready var item_list: ItemList = $ItemList

signal selected(coin: CoinResource)

var selected_coin: CoinResource:
	get:
		var selected_item = item_list.get_selected_items()

		if selected_item.size() == 0:
			push_error("No selected coin")
			return null

		# There should only ever be 1 selected item
		var index = selected_item[0]

		return item_list.get_item_metadata(index)
	set(value):
		for i in range(0, item_list.item_count):
			var coin: CoinResource = item_list.get_item_metadata(i)

			if coin == value:
				item_list.select(i)
				_on_item_selected(i)
				return


func _ready() -> void:
	item_list.item_selected.connect(_on_item_selected)

	# Clears the temp test data we need for editor view
	item_list.clear()

	for coin in ItemTypes.coins.values():
		item_list.add_item(coin.name, coin.icon)
		item_list.set_item_metadata(item_list.item_count - 1, coin)

	# Defaulting first item so that temp test data doesn't show
	_on_item_selected(0)
	item_list.select(0)


func _on_item_selected(index: int):
	var coin: CoinResource = item_list.get_item_metadata(index)

	selected.emit(coin)
