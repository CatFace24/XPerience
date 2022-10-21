extends Control

onready var pop_up_window = get_node("PopUpWindow")
onready var dialog_boxes = get_node("DialogBoxes")

var pop_up_dialog = [
	"From the defined problems and persona, a solution can be ideated to solve these problems and help the user.",
	"It is important to brainstorm together as a team, to gather as many ideas as possible to identify the best possible solution for the users!",
	"Brainstorm with your team on a viable solution for the chickens!"
]
var game_progress = 1
var dialogs

export(String, FILE, "*.json") var dialogue_file_path

# Called when the node enters the scene tree for the first time.
func _ready():
	
	##setting process for game to false
	$TransitionStageScene.set_process_input(false)
	$BrainstormGame.set_process_input(false)
	$BrainstormGame/Caption.hide()
	$BrainstormGameTwo.set_process_input(false)
	
	##calling pop up
	pop_up_window.call_pop_up("STAGE 3 - IDEATE", pop_up_dialog)


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


##when first round finished connecting
func _on_BrainstormGame_all_connected():

	pop_up_dialog = [
		"Your team is almost there, keep refining your idea!"
	]
	$BrainstormGame/Caption.hide()
	pop_up_window.show()
	pop_up_window.call_pop_up("STAGE 3 - IDEATE", pop_up_dialog)
	
func _on_PopUpWindow_pop_up_window_complete():
	
	##since pop up will complete twice, need variable true n false to differentiate
	if game_progress == 1:
		pop_up_window.hide()
		$BrainstormGame/Caption.show()
		$BrainstormGame.set_process_input(true)
		game_progress = 2
	
	else:
		pop_up_window.hide()
		$BrainstormGame.hide()
		$BrainstormGame.set_process_input(false)
		$BrainstormGameTwo.set_process_input(true)
		$BrainstormGameTwo.show()


func _on_DialogBoxes_dialog_completed():
	##transition to scene 4
	$TransitionStageScene.set_process_input(true)
	$TransitionStageScene.show()
	$TransitionStageScene.set_content("STAGE 4", "Prototype", 4)


##when wiregame finishes for the second time
func _on_BrainstormGameTwo_all_connected():
	$CompletedSound.play()
	$BrainstormGameTwo/Caption.hide()
	
	##start dialogue
	load_json(dialogue_file_path)
	dialog_boxes.show()
	dialog_boxes.call_dialog_box(dialogs)

