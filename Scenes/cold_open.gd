extends Node2D

@onready var anim_player: AnimationPlayer = %TextAnimations
@onready var date: RichTextLabel = $Date
@onready var cold_open_text: RichTextLabel = $ColdOpenText

@onready var has_played_date = false
@onready var has_played_cold_open = false

@onready var next_scene = "res://Entities/UI/interface.tscn"
@onready var main_scene = get_parent()
@onready var current_scene = get_node("/root/Main/ColdOpen")

func _ready() -> void:
	anim_player.play("fade_in_date")
	await anim_player.animation_finished
	anim_player.play_backwards("fade_in_date")
	await anim_player.animation_finished
	anim_player.play("write_cold_open")
	await anim_player.animation_finished
	SceneManager.swap_scenes(next_scene, main_scene, current_scene)
