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
	$TextureProgress.value += 1 
	loading = $TextureProgress.value
	

##function to change scene after loading is finished
func finished_loading():
	get_tree().change_scene("res://WelcomeScene.tscn")
	

