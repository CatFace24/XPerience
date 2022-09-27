extends Control

#var loading = 0

onready var ux_progress = get_node("UX/UXProgress")
onready var qa_progress = get_node("QA/QAProgress")
onready var dev1_progress = get_node("Dev1/Dev1Progress")
onready var dev2_progress = get_node("Dev2/Dev2Progress")

signal bars_finished

#func _ready():
	#$FadeIn.fade_out()
	
func start_simulation():
	$FadeIn.fade_out()


func _on_Timer_timeout():
	##Texture Progress
	ux_progress.value += 1 ## 0 - 100
	qa_progress.value += 1
	dev1_progress.value += 1
	dev2_progress.value += 1
	
	#loading = ux_progress.value
	#if loading == 100:
		#finished_loading()
	
##function to change scene after loading is finished
func finished_loading():
	emit_signal("bars_finished")
	

func _on_FadeIn_fade_finished():
	$Timer.start()

##getting value of progress bar n getting max value
func _on_Dev1Progress_value_changed(value):
	if dev1_progress.value == dev1_progress.max_value:
		print("simulation finished~")
		finished_loading()
