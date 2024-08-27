extends Node

var dialogue_states: Array[String] = []

@onready var interface: Node = get_tree().get_first_node_in_group("interface")
@onready var viewport = interface.get_node("UIContainer/RightUI/ViewUI/Room")


func ritual_start():
	var ritual_scene = preload("res://Entities/Rooms/ritual_scene.tscn").instantiate()
	viewport.add_child(ritual_scene)
	
func set_dialogue_state(dialogue_flag: String):
	dialogue_states.append(dialogue_flag)
	
func get_dialogue_state(dialogue_flag: String):
	return dialogue_states.has(dialogue_flag)

func clear():
	pass
