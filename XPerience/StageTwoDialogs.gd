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
##to trigger wire game
var wire = false
##to trigger completed persona
var persona = false
##Variable to store dialog_index to display certain diagrams for explanation through _process
var pop_up_index
##variable to change bgm
var main_bgm
var wire_game_bgm = preload("res://SoundEffects/happier bgm short.wav")


onready var pop_up_window = get_node("PopUpWindow")
onready var dialog_boxes = get_node("DialogBoxes")

export(String, FILE, "*.json") var dialogue_file_path


func _ready():
	$TransitionStageScene.set_process_input(false)
	$TransitionStageScene.hide()
	$WireGame.set_process_input(false)
	$WireGame.hide()
	$MeetingRoom.normal_meeting_room()
	$TextureButton.hide()
	$TextureButton.set_process_input(false)
	dialog_boxes.hide()
	pop_up_window.call_pop_up("STAGE 2 - DEFINE", pop_up_dialog)


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
		pop_up_window.hide()
		load_json(dialogue_file_path)
		dialog_boxes.show()
		dialog_boxes.call_dialog_box(dialogs)
		
	elif wire == true and persona == false:
		pop_up_window.hide()
		main_bgm = $"/root/MainBGM" 
		main_bgm.stream = wire_game_bgm
		main_bgm.play()
		$WireGame.show()
		$WireGame.set_process_input(true)

	if persona == true: 
		pop_up_window.hide()
		$TextureButton.show()
		$TextureButton.set_process_input(true)
		$WireGame.persona_completed()

	
func _on_DialogBoxes_button_pressed():
	dialog_index = dialog_boxes.get_dialog_index()


func _on_DialogBoxes_dialog_completed():
	dialog_boxes.hide()
	
	pop_up_dialog = [
		"Creating a persona is a team effort, it is important that every member of the team knows who they are creating a solution for!",
		"Connect the wires to create the persona with your team!"
	]
	
	pop_up_window.show()
	pop_up_window.call_pop_up("STAGE 2 - DEFINE", pop_up_dialog)

	wire = true


func _on_PopUpWindow_dialog_index_fully_updated():
	pass # Replace with function body.


func _on_WireGame_all_connected():
	
	$CompletedSound.play()
	persona = true
	
	pop_up_dialog = [
		"The user persona looks good, great job! This will help in the brainstorming stage later.",
		"Read through the persona to understand the chickens better!"
	]
	
	pop_up_window.show()
	pop_up_window.call_pop_up("STAGE 2 - DEFINE", pop_up_dialog)
	
	
func _on_TextureButton_pressed():
	$TextureButton/AudioStreamPlayer.play()
	$TextureButton.hide()
	$TextureButton.set_process_input(false)
	$TransitionStageScene.set_process_input(true)
	$TransitionStageScene.show()
	$TransitionStageScene.set_content("STAGE 3", "Ideate", 3)
