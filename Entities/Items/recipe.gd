extends Resource
class_name Recipe

@export var item: Item
@export var other: Item
@export var produces: Array[Item] = []

func matches(item: Item, other: Item) -> bool:
	if item == other:
		print("Tried to combine an item with itself! %s, %s" % [item, other])
		return false
		
	return (self.item == item or self.other == item) and (self.item == other or self.other == other)
