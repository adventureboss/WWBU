@tool
extends TextureRect

@export var item: Item

@export var dialogue_resource: DialogueResource = load("res://Entities/Dialogues/items.dialogue")
@export var dialogue_start: String = "start"

@onready var dialogue_bubble = get_tree().get_first_node_in_group("dialogue_bubble")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var state
	if not Engine.is_editor_hint():
		state = PersistenceSystem.get_object_state(self, true) #True indicates the pickup is active in the world, false that it isn't
	else:
		state = true
	
	if state:
		self.texture = item.Sprite
	else:
		self.queue_free()

func pick_up():
	InventorySystem.add_item(item)
	if item.DisplayName == "Old Worn Note in a Foreign Language":
		PersistenceSystem.note_in_inventory = true
	PersistenceSystem.set_object_state(self, false)
	self.queue_free()

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed: # need to put a timer or something in here to prevent single click triggering
			if dialogue_resource != null:
				dialogue_bubble.start(dialogue_resource, dialogue_start)
		if event.double_click:
			pick_up()
