extends Node

signal item_added(item: Item)
signal item_removed(item: Item)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func has_item(item: Item) -> bool:
	return false
	
func clear():
	pass

func add_item(item: Item):
	emit_signal("item_added", item)
	
func remove_item(item: Item):
	emit_signal("item_removed", item)

# Attempts to combine the given items, return true if successful, otherwise false, and emits signals for any changes to inventory content
func combine_items(first: Item, second: Item) -> bool:
	return false
