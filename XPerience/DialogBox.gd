extends Control
##Variable to store dialog_index to display certain diagrams for explanation through _process
var pop_up_index

##popupwindow node
#export (NodePath) var pop_up_path
onready var popUpWindow = get_node("PopUpWindow")
onready var dialogBoxes = get_node("DialogBoxes")

##dialogue json file path
export(String, FILE, "*.json") var dialogue_file_path

##This variable needs to recognize how many dialogs there are
var dialog_index
var dialog_size
var dialogs

##function to call text
func _ready():
	$ConstructionSite.hide()
	$TeamIntro.hide()
	$PopUpWindow.hide()
	load_json(dialogue_file_path)
	dialogBoxes.call_dialog_box(dialogs)
	dialog_size = 	dialogBoxes.get_dialog_size()

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
		$DialogBoxes.hide()
		
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
	if pop_up_index == 1:
		$SprintLayout.show()
	if pop_up_index != 1:
		$SprintLayout.hide()
		

##function to show pop up window
func show_pop_up():
	$DialogBoxes.hide()
	
	##Tutorial??##########
	
	##Calling pop up window
	$PopUpWindow.visible = true
	$PopUpWindow.call_pop_up("PROLOGUE", 
	["Before you start, let's get you familiar with the sprint layout.", 
	"This is how the sprint will flow:",
	"The sprint is divided into 6 stages: \n\nEmpathize, Define, Ideate, Prototype, Test, Develop", 
	"The first 5 stages are part of the design sprint, which are based on the design thinking process.\n\nDesign thinking is an iterative process that teams can use to uncover user needs.",
	"How design thinking looks like: *insert diagram again*",
	"This process is helpful as it focuses on the user and frames the problem around them, making it user-centric! User centricity means putting the user first in all stages. \n\nThe team can then focus on what is most important to the user.",
	"Don't worry if it sounds foreign, more will be explained later! \n\nYour job is to go through all the stages and produce a successful feature for the chickens, good luck!"
	
	])


##Function to switch scenes (appropriately) when button from dialogbox is pressed
func _on_DialogBoxes_button_pressed():
	dialog_index = dialogBoxes.get_dialog_index()
	
	if dialog_index >= 3:
		switch_scenes()

	##calling pop up window
	if dialog_index == dialog_size:
		show_pop_up()


func _on_PopUpWindow_dialog_index_fully_updated():
	pop_up_index = $PopUpWindow/PopUpWindow.get_dialog_index()
	print("Pop up index: ", pop_up_index)
	pop_up_window_img()

##switch to transition scene after popup is completed
func _on_PopUpWindow_pop_up_window_complete():
	$TransitionStageScene.show()
	$TransitionStageScene.set_content("STAGE 1", "Empathize")
