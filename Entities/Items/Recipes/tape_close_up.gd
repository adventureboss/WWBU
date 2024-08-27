extends Panel

@onready var reverse_switch: CheckButton = %ReverseSwitch

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reverse_switch.button_pressed = GameManager.last_known_tape_toggle

func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		if InventorySystem.has_item(preload("res://Entities/Items/TapePlayer.tres")):
			InventorySystem.remove_item(preload("res://Entities/Items/TapePlayer.tres"))
			InventorySystem.add_item(preload("res://Entities/Items/ReverseTapePlayer.tres"))
		if InventorySystem.has_item(preload("res://Entities/Items/LoadedTapePlayer.tres")):
			InventorySystem.remove_item(preload("res://Entities/Items/LoadedTapePlayer.tres"))
			InventorySystem.add_item(preload("res://Entities/Items/ReverseLoadedTapePlayer.tres"))
		else:
			pass
	if not toggled_on:
		if InventorySystem.has_item(preload("res://Entities/Items/ReverseTapePlayer.tres")):
			InventorySystem.remove_item(preload("res://Entities/Items/ReverseTapePlayer.tres"))
			InventorySystem.add_item(preload("res://Entities/Items/TapePlayer.tres"))
		if InventorySystem.has_item(preload("res://Entities/Items/ReverseLoadedTapePlayer.tres")):
			InventorySystem.remove_item(preload("res://Entities/Items/ReverseLoadedTapePlayer.tres"))
			InventorySystem.add_item(preload("res://Entities/Items/LoadedTapePlayer.tres"))
		else:
			pass


func _on_close_button_up() -> void:
	GameManager.last_known_tape_toggle = reverse_switch.button_pressed
	queue_free()
