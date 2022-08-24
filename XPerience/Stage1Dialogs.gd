extends Control


##for popup window
var pop_up_dialog = [
	"Talk to the UX Designer to know more!"	
]

##This variable needs to recognize how many dialogs there are
var dialog_index
var dialogs
var test = false
##Variable to store dialog_index to display certain diagrams for explanation through _process
var pop_up_index

onready var popUpWindow = get_node("PopUpWindow")
onready var dialogBoxes = get_node("DialogBoxes")
export(String, FILE, "*.json") var dialogue_file_path

func _ready():
	dialogBoxes.hide()
	popUpWindow.call_pop_up("EMPATHIZE", pop_up_dialog)
	#load_json(dialogue_file_path)
	#dialogBoxes.call_dialog_box(dialogs)

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
	load_json(dialogue_file_path)
	dialogBoxes.show()
	dialogBoxes.call_dialog_box(dialogs)

func _on_DialogBoxes_button_pressed():
	dialog_index = dialogBoxes.get_dialog_index()
	switch_ux_sprite()
