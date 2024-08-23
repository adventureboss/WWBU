extends Button
class_name Actionable

@onready var interface: Node = get_tree().get_first_node_in_group("interface")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_pressed() -> void:
	if PersistenceSystem.safe_opened:
		print("safe already open") #FIX: need some dialogue
	else:
		var safe_minigame: Node = preload("res://Entities/Minigames/safe.tscn").instantiate()
		interface.add_child(safe_minigame)