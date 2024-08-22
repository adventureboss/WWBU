extends TextureRect
class_name InventorySlot

@export var Item: Item

func _init():
	self.custom_minimum_size = Vector2(90,90)
	self.expand_mode = self.EXPAND_IGNORE_SIZE
	pass
