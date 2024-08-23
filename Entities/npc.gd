extends Control
class_name NPC

@export var dialogue_resource: DialogueResource
@export var item_titles: Dictionary
@export var dialogue_start: String = "start"
@export var unhandled_item_title: String = "unhandled_item"
@onready var dialogue_bubble = get_tree().get_first_node_in_group("dialogue_bubble")

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data.Item is Item

func _drop_data(at_position: Vector2, data: Variant):
	var item = data.Item
	if item_titles.has(item):
		dialogue_bubble.start(dialogue_resource, item_titles[item])
		

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed: # need to put a timer or something in here to prevent single click triggering
			if dialogue_resource != null:
				dialogue_bubble.start(dialogue_resource, dialogue_start)