extends Node
class_name DirectionControls

@export var room_parent: Node
@export var active_room_background: Color
@export var starting_room: RoomButton

@onready var car: Button = %Car

var active_room: RoomButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_room(starting_room)
	PersistenceSystem.connect("car_opened", _on_car_opened)

# May want to deactivate current (with some traveling placeholder behind it), do other stuff, then activate new with an animation
func change_room(button: RoomButton):
	if button.text == "Car" and PersistenceSystem.car_door_unlocked != true:
		var dialogue_bubble = get_tree().get_first_node_in_group("dialogue_bubble")
		dialogue_bubble.start(load("res://Entities/Dialogues/scene_objects.dialogue"), "car")
		return
	if active_room != null:
		active_room.show_inactive()
	
	for child in room_parent.get_children(): #Burn the current room
		room_parent.remove_child(child)
		child.queue_free()
		
	PersistenceSystem.set_active_room(button.room_scene.resource_path, button.text)
		
	var room = button.room_scene.instantiate() # May want to make async if loading times are noticeable
	room_parent.add_child(room)

	
	active_room = button
	active_room.show_active()


func _on_car_opened():
	car.modulate = Color(1.0, 1.0, 1.0, 1.0)
	GameManager.set_dialogue_state("car_opened")
	PersistenceSystem.car_door_unlocked = true
	change_room(car)
