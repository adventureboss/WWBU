extends Node

@export var minute_hand: Control
@export var hour_hand: Control

const DEGREES_PER_MINUTE: float = 360 / 60
const DEGREES_PER_HOUR: float = 360 / 12

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_clock() # Replace with function body.
	TimeSystem.connect("minute_passed", update_clock)

func update_clock():
	var remaining: float = TimeSystem.remaining_time_minutes()
	
	var hour: float = 11 + (remaining / 60)
	var minute: float = 60 - remaining
	
	hour_hand.rotation_degrees = hour * DEGREES_PER_HOUR
	minute_hand.rotation_degrees = minute * DEGREES_PER_MINUTE
