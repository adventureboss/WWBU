extends TextureRect

@export var item: Item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var state = PersistenceSystem.get_object_state(self, true) #True indicates the pickup is active in the world, false that it isn't
	if state:
		self.texture = item.Sprite
	else:
		self.queue_free()

func pick_up():
	InventorySystem.add_item(item)
	PersistenceSystem.set_object_state(self, false)
	self.queue_free()

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			pick_up()
