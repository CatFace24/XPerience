extends Control

var title
var dialog
onready var popUpWindow = get_node("PopUpWindow")

signal dialog_index_fully_updated
signal pop_up_window_complete

func _ready():
	pass # Replace with function body.

##to be called by current scene
func call_pop_up(stage, dialog_array):
	title = stage
	dialog = dialog_array
	popUpWindow.display_text(title, dialog)


#func _on_NextButton_pressed():
	#emit_signal("next_button_pressed")

#func _on_BackButton_pressed():
	#emit_signal("back_button_pressed")


func _on_PopUpWindow_dialog_index_updated():
	emit_signal("dialog_index_fully_updated")
	

func _on_PopUpWindow_pop_up_window_finished():
	emit_signal("pop_up_window_complete")
