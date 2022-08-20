extends Control

var dialog
var char_speaking
var dialog_index
onready var dialog_box = get_node("DialogWindowAndIcon")

signal button_pressed

func _ready():
	pass # Replace with function body.
 
##to be called by current scene
func call_dialog_box(dialog_array, character_order):
	dialog = dialog_array
	char_speaking = character_order
	dialog_box.display_dialog(dialog, char_speaking)
	
func get_dialog_index():
	dialog_index = dialog_box.get_dialog_index()
	return dialog_index

##when the 'next' button is pressed, signal emitted from child
##to be used for scene change in welcome stage
func _on_TextureButton_pressed():
	emit_signal("button_pressed")
