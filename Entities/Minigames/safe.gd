extends Control

var combination: String = "4783"
var keypresses: Array[String]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func press_button(button) -> void:
	print(button)
	if len(keypresses) < 4:
		keypresses.append(button)
	if len(keypresses) == 4:
		check_solution()
	
func check_solution():
	if "".join(keypresses) == combination:
		print("opened it!") #add a sound and success state
	else:
		print("failed")
		keypresses = []
