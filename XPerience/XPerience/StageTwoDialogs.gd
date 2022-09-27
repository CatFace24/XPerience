extends Control

##for popup window (NOT COMPLETE)
var pop_up_dialog = [
	"This is the second stage!",
	"test"	
]

##This variable needs to recognize how many dialogs there are
var dialog_index
var dialogs

##to trigger transition screen
var transition = false

##to trigger wire game
var wire = false

##to trigger completed persona
var persona = false

##Variable to store dialog_index to display certain diagrams for explanation through _process
var pop_up_index

onready var popUpWindow = get_node("PopUpWindow")
onready var dialogBoxes = get_node("DialogBoxes")

export(String, FILE, "*.json") var dialogue_file_path

func _ready():
	$TransitionStageScene.set_process_input(false)
	$TransitionStageScene.hide()
	$WireGame.set_process_input(false)
	$WireGame.hide()
	$MeetingRoom.normal_meeting_room()
	$MeetingRoom/ColorRect.hide()
	$FadeIn.hide()
	dialogBoxes.hide()
	popUpWindow.call_pop_up("STAGE 2 - DEFINE", pop_up_dialog)

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
	print("PopUpWindow completed")
	print("persona true? ", persona)
	
	if wire == false and persona == false: 
		popUpWindow.hide()
		load_json(dialogue_file_path)
		dialogBoxes.show()
		dialogBoxes.call_dialog_box(dialogs)
		
	elif wire == true and persona == false:
		popUpWindow.hide()
		#$MeetingRoom.hide()
		$WireGame.show()
		$WireGame.set_process_input(true)
		#$FadeIn.show()
		#$FadeIn.fade_in()
		
	if persona == true: 
		popUpWindow.hide()
		$WireGame.persona_completed()
		##animation end?
		$TextureButton.show()

func _on_FadeIn_fade_finished():
	pass
	#$UserInterview.show()
	#$UserInterview/TestingProgress.start_interview()
	
func _on_DialogBoxes_button_pressed():
	dialog_index = dialogBoxes.get_dialog_index()
	
func _on_DialogBoxes_dialog_completed():
	
	dialogBoxes.hide()
	
	pop_up_dialog = [
		"Connect the wires!",
		"Testing"
	]
	
	popUpWindow.show()
	popUpWindow.call_pop_up("STAGE 2 - DEFINE", pop_up_dialog)

	wire = true

func _on_PopUpWindow_dialog_index_fully_updated():
	pass # Replace with function body.


func _on_WireGame_all_connected():
	
	persona = true
	
	pop_up_dialog = [
		"The user persona looks good, great job! This will help in the brainstorming stage later.",
		"Read through the persona to understand the chickens better!"
	]
	
	popUpWindow.show()
	popUpWindow.call_pop_up("STAGE 2 - DEFINE", pop_up_dialog)
	
	
func _on_TextureButton_pressed():
	$TransitionStageScene.set_process_input(true)
	$TransitionStageScene.show()
	$TransitionStageScene.set_content("STAGE 3", "Ideate", 2)
