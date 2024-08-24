extends Control

@onready var inventory_grid: GridContainer = $MarginContainer/InventoryGrid

@onready var dialogue_bubble = get_tree().get_first_node_in_group("dialogue_bubble")


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
	
	var dragItem = dragSlotNode.item
	var targetItem = targetSlotNode.item
	
	if targetItem != null: # Drop node has an item in it
		if InventorySystem.can_combine_items(dragItem, targetItem): # Combine if possible
			InventorySystem.combine_items(dragItem, targetItem)
		else: # Swap them
			set_item_in_slot(dragSlotNode, targetItem)
			set_item_in_slot(targetSlotNode, dragItem)
	else: # Move					
		set_item_in_slot(targetSlotNode, dragItem)
		clear_item_in_slot(dragSlotNode)

func set_item_in_slot(slot: InventorySlot, item: Item):
	slot.item = item
	slot.texture = item.Sprite
	slot.tooltip_text = item.DisplayName
	
func clear_item_in_slot(slot: InventorySlot):
	slot.texture = load("res://Entities/UI/Item_types.png")
	slot.tooltip_text = ""
	slot.item = null
	
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
		

func remove_item(item):
	for slot in inventory_grid.get_children():
		if slot.item == item:
			clear_item_in_slot(slot)
			return

func _on_items_combined(item: Item):
	if item.DisplayName == "Lit Birthday Candles":
		dialogue_bubble.start(load("res://Entities/Dialogues/items.dialogue"), "combo_candles_lighter")
		return
	if item.DisplayName == "Wine Bottle (A Screw in the Cork)":
		dialogue_bubble.start(load("res://Entities/Dialogues/items.dialogue"), "combo_booze_screw")
		return
	if item.DisplayName == "Wine Bottle (Open)":
		dialogue_bubble.start(load("res://Entities/Dialogues/items.dialogue"), "combo_booze_hammer")
		return
	if item.DisplayName == "A Cassette Player with a Cassette":
		dialogue_bubble.start(load("res://Entities/Dialogues/items.dialogue"), "combo_tape_player")
		return


func _on_gui_input(event: InputEvent) -> void:
		if event is InputEventMouseButton:
			if event.is_released():
				var item_in_position = get_slot_node_at_position(self.get_local_mouse_position())
				if item_in_position.texture == load("res://Entities/UI/Item_types.png"):
					return
				if item_in_position.item.Dialogue != null:
					print("this fired")
					dialogue_bubble.start(item_in_position.item.Dialogue, item_in_position.item.DialogueStart)
			
