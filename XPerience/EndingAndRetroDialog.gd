extends Control

##for popup window (NOT COMPLETE)
var pop_up_dialog = [
	"From the data and insights collected, you and your team can now define and understand the user's pain points and identify the problem and user's goals clearly! \n\nBy defining the problem statement clearly, a better solution can be built!",
	"Conduct this stage together with your team!"   
]
##This variable needs to recognize how many dialogs there are
var dialog_index
var dialogs
##to trigger transition screen
var transition = false
##Variable to store dialog_index to display certain diagrams for explanation through _process
var pop_up_index

signal hide_stage

#onready var pop_up_window = get_node("PopUpWindow")
onready var dialog_boxes = get_node("DialogBoxes")

export(String, FILE, "*.json") var dialogue_file_path


func _ready():
	
	$ConstructionSite/Unhappy.hide()
	$ConstructionSite/Happy.show()
	$UXProcesses.hide()
	$EndCredits.set_process_input(false)
	$EndCredits.hide()
	
	load_json(dialogue_file_path)
	dialog_boxes.show()
	dialog_boxes.call_dialog_box(dialogs)


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


##switch to dialogs when popup finishes
func _on_PopUpWindow_pop_up_window_complete():
	pass

	
func _on_DialogBoxes_button_pressed():
	dialog_index = dialog_boxes.get_dialog_index()
	switch_scenes()


func switch_scenes():
	if dialog_index == 4:
		$UXProcesses.show()
	
	if dialog_index == 5:
		$UXProcesses/Indicator/AnimationPlayer.play("Define")
	
	if dialog_index == 6:
		$UXProcesses/Indicator/AnimationPlayer.play("Ideate")
	
	if dialog_index == 7:
		$UXProcesses/Indicator/AnimationPlayer.play("Prototype")
		
	if dialog_index == 8:
		$UXProcesses/Indicator/AnimationPlayer.play("Test")
		
	if dialog_index == 9:
		$UXProcesses/Indicator/AnimationPlayer.play("Implement")
		
	if dialog_index == 10:
		$UXProcesses.hide()


func _on_DialogBoxes_dialog_completed():
	emit_signal("hide_stage")
	$EndCredits.set_process_input(true)
	$EndCredits.show()
	$EndCredits.start_credits()

