extends Control

##several parts of a dialog
var dialog = [
	"Welcome to the company! We are excited to have you as our newly hired Product Owner.",
	"Hello Manager! Thanks for the warm welcome, looking forward to work with you.",
	"Great! Let me brief you on our project at the moment.",
	"The chickens at construction site are facing a problem at the jobsite;",
	"A measuring software is being developed and we are currently working on a particular feature that utilizes a brand new technology.",
	"However, the chickens seem to have a hard time using the tools efficiently. There have been many reports of its bugs and inefficiencies.",
	"If we manage to pull this off, it will be industry-breaking!",
	"Clearly, a solution is needed to help the chickens. We have the resources to develop this measuring software and increase our efficiency!",
	"But to do so, we need you and your team's help.",
	"Let me introduce you to the team you will be working with.",
	"Hi! I will be the Scrum Master of the team who will be in charge of running scrum ceremonies and hosting daily standups.",
	"Hello! We are the dev dogs. We will cover the development stage and handle technical aspects of the project.",
	"Hi there! I am the Quality Assurance Engineer who will run tests and assess if the requirements of the project are met.",
	"Hey there, I am the UX Designer! I advocate for the end-users and improve the user experience of the products by applying user centricity in the project.",
	"Looks like a great team, nice to meet everybody!",
	"I have already done some backlog grooming with the solution architect and business analyst.",
	"We would like you to focus on a particular feature this sprint!",
	"I see, sounds like a plan!",
	"Great! Time to get started on the project then; we are running on a deadline. All the best!"
]

##order of characters talking, 0 = manager, 1 = PO, 2 = SM, 3 = DEV, 4 = QA, 5 = UX
var char_speaking = [
	0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 4, 5, 1, 0, 0, 1, 0
]
##This variable needs to recognize how many dialogs there are
var dialog_index

##Variable to store dialog_index to display certain diagrams for explanation through _process
var pop_up_index

##popupwindow node
#export (NodePath) var pop_up_path
onready var popUpWindow = get_node("PopUpWindow")
onready var dialogBoxes = get_node("DialogBoxes")

##function to call text
func _ready():
	$ConstructionSite.hide()
	$TeamIntro.hide()
	$PopUpWindow.hide()

	dialogBoxes.call_dialog_box(dialog, char_speaking)

	
##function for action
func _process(delta):
	if dialog_index == dialog.size()+1:
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
	if dialog_index == dialog.size():
		show_pop_up()


func _on_PopUpWindow_dialog_index_fully_updated():
	pop_up_index = $PopUpWindow/PopUpWindow.get_dialog_index()
	print("Pop up index: ", pop_up_index)
	pop_up_window_img()

##switch to transition scene after popup is completed
func _on_PopUpWindow_pop_up_window_complete():
	$TransitionStageScene.show()
	$TransitionStageScene.set_content("STAGE 1", "Empathize")
