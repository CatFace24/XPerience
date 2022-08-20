extends Control

##for normal dialogus
var dialog = [
	"Hey there! One of the backlog is to identify low-level requirements of the users. I was wondering how can we go about this?",
	"There are many ways to empathize with users. One way is to perform user interviews!",
	"As part of user research, user interviews are a way to gather more in-depth data and research to better understand on our users.",
	"Deciding the right person to interview and designing the right interview questions are important.",
	"Let's roleplay! I will pretend to be the user. \n*wears chicken mask* \nStart by asking me a question!"
]
var char_speaking = [
	1, 5, 5, 5, 5
]

##for popup window
var pop_up_dialog = [
	"Empathize is the first stage of design thinking, and it's the first stage for a reason. \n\nIn this stage, your goal is to obtain insights and understand the users' experiences, motivations, and frustrations.",
	"This is important to put aside our judgements and assumptions and be able to observe the users as objectively as possible!",
	"Talk to the UX Designer to know more!"
	
]

##This variable needs to recognize how many dialogs there are
var dialog_index

##Variable to store dialog_index to display certain diagrams for explanation through _process
var pop_up_index

onready var popUpWindow = get_node("PopUpWindow")
onready var dialogBoxes = get_node("DialogBoxes")

func _ready():
	dialogBoxes.hide()
	popUpWindow.call_pop_up("EMPATHIZE", pop_up_dialog)
	
func switch_ux_sprite():
	if dialog_index == 4:
		##switching sprite
		$UX_Idle.switch_sprite()
		$HappyEmote.show()
		
	if dialog_index == 5:
		$HappyEmote.hide()

##switch to dialogs when popup finishes
func _on_PopUpWindow_pop_up_window_complete():
	dialogBoxes.show()
	dialogBoxes.call_dialog_box(dialog, char_speaking)

func _on_DialogBoxes_button_pressed():
	dialog_index = dialogBoxes.get_dialog_index()
	switch_ux_sprite()
