extends Node2D

var scene_path_to_load
export(String) var scene_to_load


#func _ready():
	#$Credits.hide()
	#$MeetingRoom.hide()
	#$TextureButton.hide()
	#$Background/AnimationPlayer.play("BlackBgFadeIn")
	#$TextureButton.connect("pressed", self, "_on_Button_pressed", [scene_to_load])
	

##method to be called by other classes
func start_credits():
	$Credits.hide()
	$MeetingRoom.hide()
	$TextureButton.hide()
	$Background/AnimationPlayer.play("BlackBgFadeIn")
	$TextureButton.connect("pressed", self, "_on_Button_pressed", [scene_to_load])


func _on_Button_pressed(scene_to_load):
	$TextureButton/AudioStreamPlayer.play()
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()


##connecting from the signal
func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_path_to_load)
	


##signal to show elements after bg animation finishes
func _on_AnimationPlayer_animation_finished(anim_name):
	$MeetingRoom.show()
	$MeetingRoom/PO_Idle/Shadow.hide()
	$MeetingRoom/AnimationPlayer2.play("MeetingFadeIn")


func _on_AnimationPlayer2_animation_finished(anim_name):
	$Credits.show()
	$TextureButton.show()
	$Credits/AnimationPlayer.play("EndCredits")
	$TextureButton/AnimationPlayer.play("CreditsButton")
