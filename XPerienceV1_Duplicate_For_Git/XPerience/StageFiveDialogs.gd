extends Control

##for popup window (NOT COMPLETE)
var pop_up_dialog = [
	"This is the fifth stage of design thinking - testing. In this stage, the user will be asked to use the product without explicit guidance. \n\nThis is known as usability testing.",
	"In your case, your team will show the chickens the prototype created from the previous stage!",
	"Talk to the UX designer to find out more about usability testing!" 	
]

##This variable needs to recognize how many dialogs there are
var dialog_index
var dialogs
##to trigger interview scene after last pop up window
var interview = false
##to trigger transition screen
var transition = false
##Variable to store dialog_index to display certain diagrams for explanation through _process
var pop_up_index

onready var pop_up_window = get_node("PopUpWindow")
onready var dialog_boxes = get_node("DialogBoxes")

export(String, FILE, "*.json") var dialogue_file_path


func _ready():
	$TransitionStageScene.set_process_input(false)
	$TransitionStageScene.hide()
	$UserInterview.hide()
	$FadeIn.hide()
	dialog_boxes.hide()
	pop_up_window.call_pop_up("STAGE 5 - TEST", pop_up_dialog)


##method to read json file
func load_json(file_path):
	#Passes JSON file and returns it as a dictionary
	var file = File.new()
	assert(file.file_exists(file_path))
	
	if file.file_exists(file_path):
		file.open(file_path, file.READ)
		var content = parse_json(file.get_as_text())
		assert(content.size() > 0)
		dialogs = content
		return content

	
func switch_ux_sprite():
	if dialog_index == 3:
		##switching sprite
		$UX_Idle.switch_sprite()
		$HappyEmote.show()


##switch to dialogs when popup finishes
func _on_PopUpWindow_pop_up_window_complete():
	if interview == false:
		pop_up_window.hide()
		load_json(dialogue_file_path)
		dialog_boxes.show()
		dialog_boxes.call_dialog_box(dialogs)
		
	elif interview == true and transition == true:
		$TransitionStageScene.set_process_input(true)
		$TransitionStageScene.show()
		$TransitionStageScene.set_content("STAGE 6", "Implement", 2) ##to be changed!
		
	else:
		pop_up_window.hide()
		$FadeIn.show()
		$FadeIn.fade_in()


func _on_FadeIn_fade_finished():
	$UserInterview.show()
	$UserInterview/TestingProgress.start_interview()

	
func _on_DialogBoxes_button_pressed():
	dialog_index = dialog_boxes.get_dialog_index()
	switch_ux_sprite()
	
	
func _on_DialogBoxes_dialog_completed():
	
	dialog_boxes.hide()
	
	pop_up_dialog = [
		"The usability interview will start now!"
	]
	
	pop_up_window.show()
	##need to open pop up window to explain that UX designer will perform interviews
	pop_up_window.call_pop_up("STAGE 5 - TEST", pop_up_dialog)
	##then start interview scene
	interview = true


func _on_UserInterview_int_complete():
	transition = true
	
	pop_up_dialog = [
		"Congratulations! The usability interview was a success. The solution your team proposed appears to solve our users' problems efficiently!",
		"With that, your team can start bringing the solution to life!"
	]

	##get back pop up window
	pop_up_window.show()
	pop_up_window.call_pop_up("STAGE 5 - TEST", pop_up_dialog)
