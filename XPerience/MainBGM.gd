extends AudioStreamPlayer

var bgm_2 = preload("res://SoundEffects/Monplaisir.wav")


func _on_AudioStreamPlayer_finished():
	self.stream = bgm_2
	self.play()
