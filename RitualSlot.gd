extends NPC
class_name RitualSlot

@onready var ritual_slot: TextureRect = get_child(0)


@onready var item: Item = null

func _drop_data(at_position: Vector2, data: Variant):
	item = data.item
	ritual_slot.texture = item.Sprite
	ritual_slot.visible = true
	dialogue_bubble.start(dialogue_resource, unhandled_item_title)
