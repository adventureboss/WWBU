extends Node

var state = {}

# Note: will want to get current room from the scene/room manager to namespace paths to a room scene
func get_object_state(node: Node, default: Variant) -> Variant:
	var path = node.get_path()
	if state.has(path):
		return state[path]
	else:
		return default

func set_object_state(node: Node, value: Variant):
	var path = node.get_path()
	print("State for object at path %s set to %s" % [path, value])
	state[path] = value
