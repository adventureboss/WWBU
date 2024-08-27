extends Node

@export var main_background_loop: AudioStream
@export var bad_end_background_loop: AudioStream
@export var good_end_background_loop: AudioStream

@export var dynamic_background_player: AudioStreamPlayer2D
@export var chimes_player: AudioStreamPlayer2D
@export var rain_player: AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	_change_music(main_background_loop) # Note: will need to call this again on restart but not on initial start
	TimeSystem.connect("out_of_time", play_out_of_time)

func play_out_of_time():
	dynamic_background_player.stop()
	chimes_player.play()

func play_bad_end():
	_change_music(bad_end_background_loop)
	
func play_good_end():
	_change_music(good_end_background_loop)

func _change_music(music: AudioStream):
	dynamic_background_player.stream = music
	dynamic_background_player.play()
