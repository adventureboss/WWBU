extends CanvasLayer

@onready var english: RichTextLabel = $Panel/MarginContainer/English
@onready var german: RichTextLabel = $Panel/MarginContainer/German


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if PersistenceSystem.note_translated:
		english.visible = true
		german.visible = false
	else:
		english.visible = false
		german.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
