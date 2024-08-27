extends Control

var combination: String = "4892"
var keypresses: Array[String]

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var success_fail: RichTextLabel = $"../SuccessFail"
@onready var button: Button = $"../Control/Button"

@onready var dialogue_bubble = get_tree().get_first_node_in_group("dialogue_bubble")
@onready var dialogue_resource: DialogueResource = load("res://Entities/Dialogues/scene_objects.dialogue")

@export var beep_player: AudioStreamPlayer
@export var unlock_player: AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func press_button(button) -> void:
	beep_player.play()
	if len(keypresses) < 4:
		keypresses.append(button)
	if len(keypresses) == 4:
		check_solution()
	
func check_solution():
	if "".join(keypresses) == combination:
		print("opened it!") #add a sound and success state
		PersistenceSystem.safe_opened = true
		unlock_player.play()
		success_fail.visible = true
		animation_player.play("success")
		InventorySystem.add_item(InventorySystem.RITUAL_TAPE)
		dialogue_bubble.start(dialogue_resource, "collected_tape")
	else:
		print("failed")
		success_fail.visible = true
		animation_player.play("fail")
		keypresses = []


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	success_fail.visible = false
	if PersistenceSystem.safe_opened:
		button.emit_signal("button_up")
