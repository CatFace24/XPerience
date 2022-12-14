extends Node2D

##declaring variables
var stage_number = "STAGE 1"
var title = "Empathize"
var quote = "\"This is a lengthy quote by someone \n-Author\""
##variable to indicate which stage it is at, but scenes don't store...variables
var stage_index = 1

##method to be called by other classes
func set_content(stage_no, stage_name, number):
	stage_number = stage_no
	title = stage_name
	stage_index = number
	
	$StageNumber.set_text(stage_number)
	$Title.set_text(title)
	$Quote.set_text(quote)
	$Background/AnimationPlayer.play("BlackBgFadeIn")


##detecting input
func _input(event):
	if event is InputEventKey and event.pressed:
		change_to_next_scene()


func change_to_next_scene():
	if stage_index == 1:
		##go to Stage 1's scene 
		get_tree().change_scene("res://StageOneEmpathize.tscn") 
	
	if stage_index == 2:
		get_tree().change_scene("res://StageTwoDefine.tscn") 
		
	if stage_index == 3:
		get_tree().change_scene("res://StageThreeIdeate.tscn")
	
	if stage_index == 4:
		get_tree().change_scene("res://StageFourPrototype.tscn")
		
	if stage_index == 5:
		get_tree().change_scene("res://StageFiveTesting.tscn")
		
	if stage_index == 6:
		get_tree().change_scene("res://StageSixImplement.tscn")
	
	if stage_index == 7:
		get_tree().change_scene("res://EndingAndRetro.tscn")


##signal to show elements after bg animation finishes
func _on_AnimationPlayer_animation_finished(anim_name):
	$StageNumber/AnimationPlayer.play("StageNameFade")
	$Title/AnimationPlayer.play("TitleFadeIn")
	$Quote/AnimationPlayer.play("QuoteFadeIn") ##quote got issues
	$TapToContinue/AnimationPlayer.play("ContinueTextFade")
