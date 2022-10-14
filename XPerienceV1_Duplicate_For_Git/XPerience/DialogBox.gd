extends Control
##Variable to store dialog_index to display certain diagrams for explanation through _process
var pop_up_index
##This variable needs to recognize how many dialogs there are
var dialog_index
var dialog_size
var dialogs

onready var pop_up_window = get_node("PopUpWindow")
onready var dialog_boxes = get_node("DialogBoxes")

##dialogue json file path
export(String, FILE, "*.json") var dialogue_file_path


##function to call text
func _ready():
	$TransitionStageScene.set_process_input(false)
	$ConstructionSite.hide()
	$TeamIntro.hide()
	pop_up_window.hide()
	load_json(dialogue_file_path)
	dialog_boxes.call_dialog_box(dialogs)
	dialog_size = 	dialogs.size()


func load_json(file_path):
	#Passes JSON file and returns it as a dictionary
	var file = File.new()
	assert(file.file_exists(file_path))
	
	if file.file_exists(file_path):
		file.open(file_path, file.READ)
		var content = parse_json(file.get_as_text())
		assert(content.size() > 0)
		print("\nparsed JSON:")
		dialogs = content
		return content
	
	
##function for action
func _process(delta):
	if dialog_index == dialog_size + 1:
		dialog_boxes.hide()
	
		
##method to switch between different scenes based on dialog index
func switch_scenes():
	match dialog_index:
		3, 4, 5:
			$ConstructionSite.show()
		7:
			$ConstructionSite.hide()
				
		##Displaying team intro scene appropriately
		8:
			$TeamIntro.show()
				
		10, 11, 12, 13, 14:
			$TeamIntro.scale_icon()
				
		15:
			$TeamIntro.hide()
	
	
func pop_up_window_img():
	
	##Pop Up Window
	if pop_up_index == 5:
		$SprintLayout.show()
	if pop_up_index != 5:
		$SprintLayout.hide()
		
		
##function to show pop up window
func show_pop_up():
	dialog_boxes.hide()
	
	##Tutorial (nice to have)
	
	##Calling pop up window
	pop_up_window.visible = true
	pop_up_window.call_pop_up("PROLOGUE", 
	[ "Before you start, it is important to understand the basics of scrum and its elements. Scrum is a framework of how teams can work together to solve complex problems.",
	"Here's a quick overview of the different scrum events: *insert diagram of scrum events*",
	"Sprints are fixed periods of time where the team completes a set amount of work. Ideally, a sprint should last no longer than a month. Thus, with the scrum framework, the goals of each sprint can be set and daily standups occur to ensure that the team members are on the right track.",
	"The review session provides insights on what the stakeholders think while retrospectives are to discover what went well, what went wrong, and what can be improved during the sprint!",
	"It's important to know that the sprint layout will differ for various projects, so let's get you familiar with our sprint layout!.", 
	"This is how the sprint will flow:",
	"The sprint is divided into 6 stages: \n\nEmpathize, Define, Ideate, Prototype, Test, Implement", 
	"The 6 stages are part of the design sprint, which are based on the design thinking process.\n\nDesign thinking is an iterative process that teams can use to uncover user needs.",
	"How design thinking looks like: *insert diagram again*",
	"This process is helpful as it focuses on the user and frames the problem around them, making it user-centric! User centricity means putting the user first in all stages. \n\nThe team can then focus on what is most important to the user.",
	"Don't worry if it sounds foreign, more will be explained later! \n\nYour job is to go through all the stages and produce a successful feature for the chickens, good luck!"
	])


##Function to switch scenes (appropriately) when button from dialogbox is pressed
func _on_DialogBoxes_button_pressed():
	dialog_index = dialog_boxes.get_dialog_index()
	
	if dialog_index >= 3:
		switch_scenes()

	##calling pop up window
	if dialog_index == dialog_size:
		show_pop_up()


func _on_PopUpWindow_dialog_index_fully_updated():
	pop_up_index = $PopUpWindow/PopUpWindow.get_dialog_index()
	pop_up_window_img()


##switch to transition scene after popup is completed
func _on_PopUpWindow_pop_up_window_complete():
	$TransitionStageScene.set_process_input(true)
	$TransitionStageScene.show()
	$TransitionStageScene.set_content("STAGE 1", "Empathize", 1)
