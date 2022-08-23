extends Control

var loading = 0

func _ready():
	pass
	$ScrumMasterWalk/AnimationPlayer.play("WalkRight")
	
func _process(delta):
	if loading == 100:
		finished_loading()

func _on_Timer_timeout():
	##Texture Progress
	$TextureProgress.value += 1 ## 0 - 100
	loading = $TextureProgress.value
	

##function to change scene after loading is finished
func finished_loading():
	#self.queue_free()
	get_tree().change_scene("res://WelcomeScene.tscn")
	
	#$TransitionScreen.transition()
	
	#TransitionScreen.change_scene("res://WelcomeScene.tscn", "FadeInAndOut")
	
	
#func _on_TransitionScreen_transition_finished():
	#pass
