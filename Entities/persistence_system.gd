extends Node

var rooms = {}
var active_room
var active_room_name
var dialogue_bubble
var safe_opened: bool = false
var car_door_unlocked: bool = false
var found_keys: bool = false
var kazoo_found: bool = false
var opening_dialogue_played: bool = false

signal dialogue_bubble_ready
signal car_opened
signal found_kazoo

func get_object_state(node: Node, default: Variant) -> Variant:
	if not rooms.has(active_room):
		return default
		
	var state = rooms[active_room]
	var path = node.get_path()
	if state.has(path):
		return state[path]
	else:
		return default

func set_object_state(node: Node, value: Variant):
	var state
	if not rooms.has(active_room):
		state = {}
		rooms[active_room] = state
	else:
		state = rooms[active_room]
		
	var path = node.get_path()
	print("State for object at path %s set to %s" % [path, value])
	state[path] = value

func set_active_room(id: String, name: String):
	active_room = id
	active_room_name = name.to_lower()
	
func clear():
	rooms.clear()
	active_room = ""
	active_room_name = ""
	#dialogue_bubble = null # Do not reset. It's not game state and will be overwritten anyway.
	safe_opened = false
	car_door_unlocked = false
	found_keys = false
	kazoo_found = false
