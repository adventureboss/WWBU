extends Button
class_name RoomButton

signal room_change_requested(button: RoomButton)

@export var room_scene: PackedScene

func _ready() -> void:
	connect("pressed", _on_pressed)

func show_active():
	disabled = true

func show_inactive():
	disabled = false

func _on_pressed():
	emit_signal("room_change_requested", self)
