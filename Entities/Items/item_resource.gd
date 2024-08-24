extends Resource
class_name Item

@export var Sprite: Texture2D
@export var DisplayName: String
@export var DialogueStart: String
@export var Dialogue: DialogueResource = load("res://Entities/Dialogues/items.dialogue")
