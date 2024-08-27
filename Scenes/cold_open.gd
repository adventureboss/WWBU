extends Node2D

@onready var anim_player: AnimationPlayer = %TextAnimations
@onready var date: RichTextLabel = $Date
@onready var cold_open_text: RichTextLabel = $ColdOpenText

@onready var has_played_date = false
@onready var has_played_cold_open = false

@export var dialogue_resource: DialogueResource = load("res://Entities/Dialogues/cold_open.dialogue")
@export var dialogue_start: String = "start"

@onready var dialogue_bubble = get_tree().get_first_node_in_group("dialogue_bubble")

func _ready() -> void:
	anim_player.play("fade_in_date")
	await anim_player.animation_finished
	anim_player.play_backwards("fade_in_date")
	await anim_player.animation_finished
	PersistenceSystem.dialogue_bubble.start(dialogue_resource, dialogue_start)
