extends Control

@onready var inventory_grid: GridContainer = $MarginContainer/InventoryGrid

var inventory_slot_count = 15

func _ready():
	InventorySystem.connect("item_added", add_item)
	InventorySystem.connect("item_removed", remove_item)
	InventorySystem.connect("items_combined", _on_items_combined)
	
	for slot in inventory_slot_count:
		inventory_grid.add_child(InventorySlot.new())

func _get_drag_data(at_position):
	var dragSlotNode: InventorySlot = get_slot_node_at_position(at_position)	
	if dragSlotNode.texture == null: return
	var dragPreviewNode = TextureRect.new()
	dragPreviewNode.expand = true
	dragPreviewNode.texture = dragSlotNode.texture
	dragPreviewNode.custom_minimum_size = Vector2(60,60)
	
	var control = Control.new()
	control.add_child(dragPreviewNode)
	dragPreviewNode.position = -0.5 * dragPreviewNode.custom_minimum_size
	set_drag_preview(control)

	return dragSlotNode
	
func _can_drop_data(at_position, data):
	var targetSlotNode = get_slot_node_at_position(at_position)
	
	return targetSlotNode != null

func _drop_data(at_position, dragSlotNode):
	var targetSlotNode: InventorySlot = get_slot_node_at_position(at_position)
	var targetTexture = targetSlotNode.texture
	
	if InventorySystem.combine_items(dragSlotNode.item, targetSlotNode.item):
		return

	targetSlotNode.texture = dragSlotNode.texture
	targetSlotNode.tooltip_text = dragSlotNode.tooltip_text
	targetSlotNode.item = dragSlotNode.item
	
	# this is for when we swap items
	# this should be fine except where we want a combo to happen
	if targetTexture == load("res://Entities/UI/Item_types.png"):
		dragSlotNode.texture = load("res://Entities/UI/Item_types.png")
		dragSlotNode.tooltip_text = ""
		dragSlotNode.item = null
	else:
		dragSlotNode.texture = targetTexture
		dragSlotNode.tooltip_text = targetSlotNode.tooltip_text
		dragSlotNode.item = targetSlotNode.item
	
func get_slot_node_at_position(position):
	var allInventorySlots = inventory_grid.get_children()
	
	for slot in allInventorySlots:
		var slotRect = slot.get_global_rect()
		
		if slotRect.has_point(position): return slot

func add_item(item: Item):
	print("adding item")
	var slots = inventory_grid.get_children()

	for slot in slots:
		if slot.item == null:
			slot.item = item
			slot.texture = item.Sprite
			slot.tooltip_text = item.DisplayName
			return
		

func remove_item(item: Item):
	print("removing item")
	var slots = inventory_grid.get_children()
	
	for slot in slots:
		if slot.item == item:
			slot.item = null
			slot.texture = load("res://Entities/UI/Item_types.png")
			slot.tooltip_text = ""
			return

func _on_items_combined(item: Item):
	var dialogue_bubble = get_tree().get_first_node_in_group("dialogue_bubble")
	if item.DisplayName == "Lit Birthday Candles":
		dialogue_bubble.start(load("res://Entities/Dialogues/items.dialogue"), "combo_candles_lighter")
		return
	if item.DisplayName == "Wine Bottle (A Screw in the Cork)":
		dialogue_bubble.start(load("res://Entities/Dialogues/items.dialogue"), "combo_booze_screw")
		return
	if item.DisplayName == "Wine Bottle (Open)":
		dialogue_bubble.start(load("res://Entities/Dialogues/items.dialogue"), "combo_booze_hammer")
		return
