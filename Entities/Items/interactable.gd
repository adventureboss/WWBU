extends Control
class_name Interactable

@export var item: Item

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

@onready var dialogue_bubble = get_tree().get_first_node_in_group("dialogue_bubble")

func _ready() -> void:
	$Sprite2D.texture = item.Sprite
	self.custom_minimum_size = Vector2(50, 50) #fix this. Should derive the minimum size some other way

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			dialogue_bubble.start(dialogue_resource, dialogue_start)
