extends TextureRect
class_name InventorySlot

var item: Item

func _init():
	self.custom_minimum_size = Vector2(90,90)
	self.expand_mode = self.EXPAND_IGNORE_SIZE
	self.texture = load("res://Entities/UI/Item_types.png")
	self.tooltip_text = ""
	self.item = item
	pass
