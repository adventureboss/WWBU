extends Node

@onready var dialogue_bubble = get_tree().get_first_node_in_group("dialogue_bubble")
@export var monster: Control
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if TimeSystem.is_out_of_time():
		MusicSystem.play_bad_end()
		monster.visible = true
	if PersistenceSystem.get_object_state(self, false):
		# Do first time entry stuff
		PersistenceSystem.set_object_state(self, true)
