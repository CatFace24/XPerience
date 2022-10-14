extends Node2D

onready var progress_bar = get_node("InterviewProgress")

signal int_finished

#func _ready():
	#$FadeIn.fade_out()
	
	
func start_interview():
	$FadeIn.fade_out()


func _on_Timer_timeout():
	##Texture Progress
	progress_bar.value += 1
	
	
##function to change scene after loading is finished
func finished_int():
	emit_signal("int_finished")


func _on_FadeIn_fade_finished():
	$Timer.start()


##getting value of progress bar n getting max value
func _on_InterviewProgress_value_changed(value):
	if progress_bar.value == progress_bar.max_value:
		finished_int()
