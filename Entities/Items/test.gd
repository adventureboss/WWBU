extends Node2D

@export var item: Item
@export var other: Item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InventorySystem.connect("item_added", _on_item_added)
	InventorySystem.connect("item_removed", _on_item_removed)
	
	InventorySystem.add_item(item)
	print("Has it?: %s" % InventorySystem.has_item(item))
	InventorySystem.add_item(other)
	InventorySystem.combine_items(item, other)
	print("Still has it?: %s" % InventorySystem.has_item(item))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_item_added(item: Item):
	print("Added: %s" % item.DisplayName)
func _on_item_removed(item: Item):
	print("Removed: %s" % item.DisplayName)
