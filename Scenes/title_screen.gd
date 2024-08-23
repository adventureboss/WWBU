extends Node2D

@onready var button: Button = %StartButton

func _ready() -> void:
	button.connect("button_up", _on_button_up)
	
func _on_button_up():
	var next_scene = "res://Entities/UI/interface.tscn"
	var main_scene = get_parent()
	var current_scene = get_node("/root/Main/TitleScreen")
	SceneManager.swap_scenes(next_scene, main_scene, current_scene)
