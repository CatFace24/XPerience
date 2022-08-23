extends ColorRect

##Signallingthe title screen that it has finished
signal fade_finished

##function to start fading in
func fade_in():
	$AnimationPlayer.play("FadeToLoad")

func _on_AnimationPlayer_animation_finished(anim_name):
	##emitting signal
	emit_signal("fade_finished")
