extends GridContainer
class_name Slots

@export var solution: Array[Item]
@export var bad_solution: Array[Item]

signal solved

var submitted_solution: Array[Item]


func _on_begin_ritual_button_up() -> void:
	for slot in self.get_children():
		if slot.get("item"):
			submitted_solution.append(slot.item)
	if solution == submitted_solution:
		emit_signal("solved")
		return
	if len(submitted_solution) < 4:
		print("not enough items submitted. Try again")
		return
	if submitted_solution == bad_solution:
		print("game over")
	else:
		print("failed to choose correct items. Attempt again")
	
