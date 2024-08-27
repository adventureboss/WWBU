extends Node

signal minute_passed
signal out_of_time

@export var allowed_time_minutes: int
var elapsed_time_seconds: float
var elapsed_whole_minutes: int = 0

func _ready():
	set_process(false)
	
func start():
	elapsed_time_seconds = 0
	elapsed_whole_minutes = 0
	set_process(true)
	
func pause():
	set_process(false)

func resume():
	set_process(true)

func remaining_time_minutes() -> int:
	return allowed_time_minutes - elapsed_whole_minutes

func is_out_of_time() -> bool:
	return remaining_time_minutes() <= 0

func _handle_minute_passed():
	elapsed_time_seconds = 0
	elapsed_whole_minutes += 1
	emit_signal("minute_passed")
	
	if elapsed_whole_minutes >= allowed_time_minutes:
		emit_signal("out_of_time")
		pause()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float): # Whether to call _process is toggled on and off by pause/resume
	elapsed_time_seconds += delta
	if elapsed_time_seconds >= 60:
		_handle_minute_passed()
