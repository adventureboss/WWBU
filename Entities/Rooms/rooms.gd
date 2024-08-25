extends Control
class_name Room

@export var dialogue_resource: DialogueResource = load("res://Entities/Dialogues/rooms.dialogue")
@export var dialogue_start: String

func _ready() -> void:
	PersistenceSystem.connect("found_kazoo", _on_found_kazoo)
	PersistenceSystem.connect("dialogue_bubble_ready", _on_dialogue_bubble_ready)
	if PersistenceSystem.dialogue_bubble:
		PersistenceSystem.dialogue_bubble.start(dialogue_resource, dialogue_start)


func _on_dialogue_bubble_ready():
	PersistenceSystem.dialogue_bubble.start(dialogue_resource, dialogue_start)

func _on_found_kazoo():
	var bedroom_texture = get_tree().get_first_node_in_group("bedroom")
	bedroom_texture.texture = load("res://Scenes/bedroom_kazoo_found.png")
	var kazoo = bedroom_texture.find_child("Kazoo")
	kazoo.visible = true
	PersistenceSystem.kazoo_found = true
