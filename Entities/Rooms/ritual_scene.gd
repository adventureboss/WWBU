extends Control

@export var good_end: Control
@export var slots: Slots

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slots.connect("solved", _on_solved)

func _on_solved():
	visible = false
	good_end.visible = true

func _on_button_up():
	visible = false
