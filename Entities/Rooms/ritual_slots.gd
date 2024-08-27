extends GridContainer

@export var solution: Array[Item]

var submitted_solution: Array[Item]

func _on_begin_ritual_button_up() -> void:
	for slot in self.get_children():
		if slot.get("item"):
			submitted_solution.append(slot.item)
	if solution == submitted_solution:
		print("game win") # obviously this all needs to tie to dialogue
		return
	if len(submitted_solution) < 4:
		print("not enough items submitted. Try again")
		return
	solution.reverse()
	if submitted_solution == solution:
		print("game over")
	else:
		print("failed to choose correct items. Attempt again")
	