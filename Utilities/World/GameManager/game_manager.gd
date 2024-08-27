extends Node

var dialogue_states: Array[String] = [] # Set?

func _ready() -> void:
	TimeSystem.connect("out_of_time", out_of_time)

var last_known_tape_toggle: bool = false

func ritual_start():
	var interface: Node = get_tree().get_first_node_in_group("interface")
	var viewport = interface.get_node("UIContainer/RightUI/ViewUI/Room")
	var ritual_scene = preload("res://Entities/Rooms/ritual_scene.tscn").instantiate()
	viewport.add_child(ritual_scene)
	
func set_dialogue_state(dialogue_flag: String):
	dialogue_states.append(dialogue_flag)
	
func get_dialogue_state(dialogue_flag: String):
	return dialogue_states.has(dialogue_flag)

func out_of_time():
	dialogue_states.append("out_of_time")

func clear():
	dialogue_states.clear()
	last_known_tape_toggle = false
