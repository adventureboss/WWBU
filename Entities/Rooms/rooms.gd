extends Control
class_name Room

@export var dialogue_resource: DialogueResource = load("res://Entities/Dialogues/rooms.dialogue")
@export var dialogue_start: String

func _ready() -> void:
	PersistenceSystem.connect("dialogue_bubble_ready", _on_dialogue_bubble_ready)
	if PersistenceSystem.dialogue_bubble:
		PersistenceSystem.dialogue_bubble.start(dialogue_resource, dialogue_start)

func _on_dialogue_bubble_ready():
	PersistenceSystem.dialogue_bubble.start(dialogue_resource, dialogue_start)
