extends AudioStreamPlayer

@export var named_sfx: Dictionary = {}

func play_sound(name: String):
	if named_sfx.has(name):
		stream = named_sfx[name]
		play()
