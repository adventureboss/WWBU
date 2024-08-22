extends Control

@onready var inventory_grid: GridContainer = $MarginContainer/InventoryGrid

func _get_drag_data(at_position):
	var dragSlotNode = get_slot_node_at_position(at_position)
	
	if dragSlotNode.texture == null: return
	
	var dragPreviewNode = dragSlotNode.duplicate()
	dragPreviewNode.custom_minimum_size = Vector2(60,60)
	set_drag_preview(dragPreviewNode)
	
	return dragSlotNode
	
func _can_drop_data(at_position, data):
	var targetSlotNode = get_slot_node_at_position(at_position)
	
	return targetSlotNode != null
	
func _drop_data(at_position, dragSlotNode):
	var targetSlotNode = get_slot_node_at_position(at_position)
	var targetTexture = targetSlotNode.texture
	
	targetSlotNode.texture = dragSlotNode.texture
	
	if targetTexture == null:
		dragSlotNode.texture = null
	else:
		dragSlotNode.texture = targetTexture
	
func get_slot_node_at_position(position):
	var allInventorySlots = inventory_grid.get_children()
	
	for slot in allInventorySlots:
		var slotRect = slot.get_global_rect()
		
		if slotRect.has_point(position): return slot
