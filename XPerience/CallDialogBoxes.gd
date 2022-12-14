extends Control

var dialog
#var char_speaking
var dialog_index
var dialog_size
onready var dialog_box = get_node("DialogWindowAndIcon")

signal button_pressed
signal dialog_completed
signal option_pressed


##to be called by current scene
func call_dialog_box(dialogs):
	dialog_box.display_dialog(dialogs)
	
	
func get_dialog_index():
	dialog_index = dialog_box.get_dialog_index()
	return dialog_index


func get_dialog_size():
	dialog_size = dialog_box.get_dialog_size()
	return dialog_size


func reset_index():
	dialog_box.reset_dialog_index()


##when the 'next' button is pressed, signal emitted from child
##to be used for scene change in welcome stage
func _on_TextureButton_pressed():
	emit_signal("button_pressed")
	$DialogWindowAndIcon/AudioStreamPlayer.play()


func _on_DialogWindowAndIcon_dialog_finished():
	emit_signal("dialog_completed")


func _on_DialogWindowAndIcon_option_clicked():
	emit_signal("option_pressed")
