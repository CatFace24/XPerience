extends Control

##for popup window 
var pop_up_dialog = [
	"Empathize is the first stage of design thinking, and it's the first stage for a reason. \n\nIn this stage, your goal is to obtain insights and understand the users' experiences, motivations, and frustrations.",
	"This is important to put aside our judgements and assumptions and be able to observe the users as objectively as possible!",
	"Talk to the UX Designer to know more!"   
]
##This variable needs to recognize how many dialogs there are
var dialog_index
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
	$SimulationScene.hide()
	$FadeIn.hide()
	dialog_boxes.hide()
	pop_up_window.call_pop_up("STAGE 1 - EMPATHIZE", pop_up_dialog)


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
	if dialog_index == 4:
		##switching sprite
		$UX_Idle.switch_sprite()
		$HappyEmote.show()
		
	if dialog_index == 5:
		$HappyEmote.hide()


##switch to dialogs when popup finishes
func _on_PopUpWindow_pop_up_window_complete():

	if simulation == false:
		pop_up_window.hide()
		load_json(dialogue_file_path)
		dialog_boxes.show()
		dialog_boxes.call_dialog_box(dialogs)
		
	elif simulation == true and transition == true:
		$TransitionStageScene.set_process_input(true)
		$TransitionStageScene.show()
		$TransitionStageScene.set_content("STAGE 2", "Define", 2)
		
	else:
		pop_up_window.hide()
		$FadeIn.show()
		$FadeIn.fade_in()


func _on_FadeIn_fade_finished():
	$SimulationScene.show()
	$SimulationScene/LoadingBars.start_simulation()


func _on_DialogBoxes_button_pressed():
	dialog_index = dialog_boxes.get_dialog_index()
	switch_ux_sprite()
	

func _on_DialogBoxes_dialog_completed():
	dialog_boxes.hide()
	
	pop_up_dialog = [
		"While the UX designer conducts the user interview, the developers can work on backend coding simultaneously!",
		"The scrum master will also go around collecting daily updates from the team and perform scrum ceremonies."
	]
	
	pop_up_window.show()
	pop_up_window.call_pop_up("STAGE 1 - EMPATHIZE", pop_up_dialog)
	##start simulation scene
	simulation = true

func _on_SimulationScene_bars_complete():
	transition = true
	
	pop_up_dialog = [
		"The user interview is complete! Congrats, your team now has gained insights to the behaviour of the chicken construction workers. Time to continue to the next stage!"
	]

	##get back pop up window??
	pop_up_window.show()
	pop_up_window.call_pop_up("STAGE 1 - EMPATHIZE", pop_up_dialog)
