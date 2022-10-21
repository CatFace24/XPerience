extends Control

##for popup window 
var pop_up_dialog = [
	"This is stage 4, prototype!",
	"Everyone has an idea on what prototypes are: they are tangible forms of our ideas! This makes it very useful for testing as well. \nTalk to the UX designer to find out more!" 
]
##This variable needs to recognize how many dialogs there are
var dialogs
var dialog_index
##to trigger simulaiton after last pop up window
var simulation = false
##to trigger transition screen
var transition = false
##to go into stage 5 dialogues
var stage_five = false
##Variable to store dialog_index to display certain diagrams for explanation through _process
var pop_up_index
##variable to change bgm
var main_bgm
var normal_game_bgm = preload("res://SoundEffects/Monplaisir.wav")

onready var pop_up_window = get_node("PopUpWindow")
onready var dialog_boxes = get_node("DialogBoxes")

export(String, FILE, "*.json") var dialogue_file_path_one
export(String, FILE, "*.json") var dialogue_file_path_two

func _ready():
	$TransitionStageScene.set_process_input(false)
	$TransitionStageScene.hide()
	$SimulationScene.hide()
	$FadeIn.hide()
	$MeetingRoom.normal_meeting_room()
	dialog_boxes.hide()
	pop_up_window.call_pop_up("STAGE 4 - PROTOTYPE", pop_up_dialog)
	main_bgm = $"/root/MainBGM" 
	main_bgm.stream = normal_game_bgm
	main_bgm.volume_db = 3
	main_bgm.play()


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

	if simulation == false:
		pop_up_window.hide()
		load_json(dialogue_file_path_one)
		dialog_boxes.show()
		dialog_boxes.call_dialog_box(dialogs)
		
	elif simulation == true and stage_five == true:
		pop_up_window.hide()
		$FadeIn.hide()
		$MeetingRoom.hide()
		$SimulationScene/LoadingBars.hide()
		$SimulationScene/LoadingBarsBG.hide()
		transition = true
		load_json(dialogue_file_path_two)
		dialog_boxes.reset_index()
		dialog_boxes.show()
		dialog_boxes.call_dialog_box(dialogs)


func _on_FadeIn_fade_finished():
	$SimulationScene.show()
	$SimulationScene/LoadingBars.start_simulation()


func switch_prototype_scene():
	
	print("\nstage 4 sialog index ", dialog_index)
	
	if stage_five == false:
		if dialog_index == 5 or dialog_index == 17:
			$MeetingRoom/ColorRect.show()
			$"Prototype(screens)".hide()
			$"Prototype(interaction)".hide()
			$Wireframe.hide()
			$Sketches.show()
		
		if dialog_index == 8 or dialog_index == 19:
			$MeetingRoom/ColorRect.show()
			$Sketches.hide()
			$"Prototype(screens)".hide()
			$"Prototype(interaction)".hide()
			$Wireframe.show()
			
		if dialog_index == 13  or dialog_index == 21:
			$MeetingRoom/ColorRect.show()
			$Sketches.hide()
			$Wireframe.hide()
			$"Prototype(interaction)".hide()
			$"Prototype(screens)".show()
		
		if dialog_index == 15 or dialog_index == 22:
			$MeetingRoom/ColorRect.show()
			$Sketches.hide()
			$Wireframe.hide()
			$"Prototype(screens)".hide()
			$"Prototype(interaction)".show()
			
		if dialog_index >= 23:
			$MeetingRoom/ColorRect.hide()
			$Sketches.hide()
			$Wireframe.hide()
			$"Prototype(screens)".hide()
			$"Prototype(interaction)".hide()


func _on_DialogBoxes_button_pressed():
	dialog_index = dialog_boxes.get_dialog_index()
	switch_prototype_scene()
	

func _on_SimulationScene_bars_complete():
	
	stage_five = true
	
	pop_up_dialog = [
		"Creating sketches, wireframes, and prototypes have many benefits to the team! It not only brings the idea to life, but also provides a quick way to visualize the concept of the solution in a more comprehensible way!",
		"It also provide a clearer picture and flow for the developers for when they implement the solution!"
	]

	##get back pop up window
	pop_up_window.show()
	pop_up_window.call_pop_up("STAGE 4 - PROTOTYPE", pop_up_dialog)


func _on_DialogBoxes_dialog_completed():
	simulation = true
	
	if simulation == true and transition == false:
		dialog_boxes.hide()
		$FadeIn.show()
		$FadeIn.fade_in()
		
	if simulation == true and transition == true and stage_five == true:
		$TransitionStageScene.set_process_input(true)
		$TransitionStageScene.show()
		$TransitionStageScene.set_content("STAGE 5", "Test", 5)


func _on_DialogBoxes_option_pressed():
	dialog_index = dialog_boxes.get_dialog_index()
	switch_prototype_scene()
