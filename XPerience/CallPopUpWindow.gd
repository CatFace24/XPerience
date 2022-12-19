extends Control

var title
var dialog

onready var pop_up_window = get_node("PopUpWindow")

signal dialog_index_fully_updated
signal pop_up_window_complete


##to be called by current scene
func call_pop_up(stage, dialog_array):
	title = stage
	dialog = dialog_array
	pop_up_window.display_text(title, dialog)


##getting signal from child
func _on_PopUpWindow_dialog_index_updated():
	emit_signal("dialog_index_fully_updated")
	

##getting signal from child
func _on_PopUpWindow_pop_up_window_finished():
	print("Pop Up Finished!!!")
	emit_signal("pop_up_window_complete")
