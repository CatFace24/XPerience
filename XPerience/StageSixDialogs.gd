extends Control

##for popup window 
var pop_up_dialog = [
	"You and your team are almost there, keep it up! \nBecause of all the UX processes, interviews, prototypes and testings before, the team can be rest assured that they can fully invest into developing this product!",
	"This saves time and resources in development as the need for major reworks are greatly reduced.",
	"Do note that this is a simplified version of a sprint! When you get back to real life, you may face more complex challenges and problems that results in different outcomes. Please take this as a general overview :)",
	"In this stage, the UX designer will handoff the project to the developers! All relevant assets, components and elements should be organized and labelled accordingly for the developers' ease of use.",
	"This is to ensure that the developers have a comprehensive understanding of the final prototype."  
	
]
##This variable needs to recognize how many dialogs there are
var dialogs
##to trigger simulaiton after last pop up window
var simulation = false
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
	$SimulationScene/LoadingBars.hide()
	$SimulationScene/LoadingBarsBG.hide()
	dialog_boxes.hide()
	pop_up_window.call_pop_up("STAGE 6 - IMPLEMENT", pop_up_dialog)


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
	
	pop_up_window.hide()
	
	$SimulationScene/LoadingBars.show()
	$SimulationScene/LoadingBarsBG.show()
	$SimulationScene/LoadingBars.start_simulation()


func _on_DialogBoxes_dialog_completed():

	$TransitionStageScene.set_process_input(true)
	$TransitionStageScene.show()
	$TransitionStageScene.set_content("ENDING", "Retrospective", 7)


func _on_SimulationScene_bars_complete():
	
	$SimulationScene/LoadingBars.hide()
	$SimulationScene/LoadingBarsBG.hide()
	
	load_json(dialogue_file_path)
	dialog_boxes.show()
	dialog_boxes.call_dialog_box(dialogs)
