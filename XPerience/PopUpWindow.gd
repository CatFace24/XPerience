extends Control

var title = "Filler Title"
var dialog = ["Before you start, let's get you familiar with the sprint layout.", 
	"This is how the sprint will flow:",
	"The sprint is divided into 6 stages: \n\nEmpathize, Define, Ideate, Prototype, Test, Develop"
	]
var dialog_index = 0
var finished = false
var all_finished = 0
##for back button logic
var back_button_just_pressed = false


##signal that dialog_index is final
signal dialog_index_updated

##signal to indicate that pop up window is entirely finished
signal pop_up_window_finished

##Getting nodes on ready
export (NodePath) var next_button_path ##script variable in inspector
export (NodePath) var back_button_path

onready var next_button = get_node(next_button_path)
onready var back_button = get_node(back_button_path)

func _ready():
	#$BackButton.visible = false
	#$NextButton.visible = false
	#load_title()
	#load_dialog()
	# Create connection for normal button
	next_button.connect("pressed", self, "load_dialog")
	back_button.connect("pressed", self, "back_explanation")
	

##function to getting dialog index number
func get_dialog_index():
	print("get_dialog_index from PopUpWindow: ", dialog_index)
	return dialog_index


##to be called by current scene
func display_text(stage, dialog_array):
	dialog_index = 0
	title = stage
	dialog = dialog_array
	
	$BackButton.visible = false
	$NextButton.visible = false
	load_title()
	load_dialog()


##function for action
func _process(delta):
	$NextButton.visible = finished
	
	
func back_explanation():
	$AudioStreamPlayer.play()
	dialog_index -= 2
	##Accessing the dialog of the particular index
	if dialog_index < 1 or dialog_index == 0:
		$BackButton.visible = false
		dialog_index = 0
	
	##emitting signal of dialog_index
	emit_signal("dialog_index_updated")
	
	##Displaying page no
	$PageNo.text = str((dialog_index + 1), " / ", dialog.size())
	
	##Displaying content
	$Content.bbcode_text = dialog[dialog_index]
	$Content.percent_visible = 1
	back_button_just_pressed = true
	
	dialog_index += 1

	
func load_title():
	$Title.bbcode_text = title
	$Title.percent_visible = 0
	$Tween.interpolate_property(
		$Title, "percent_visible",
		0.0, 1, (dialog[dialog_index].length()/24) , Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	

func load_dialog():
	##play sound effect
	$AudioStreamPlayer.play()
	
	##if dialog index is less than dialog array size, means there is still text
	if dialog_index < dialog.size():
		##setting visibility of backbutton
		if dialog_index >= 1:
			$BackButton.visible = true
			
		finished = false
		
		##emitting signal of dialog_index
		emit_signal("dialog_index_updated")
		##Displaying page numbers
		$PageNo.text = str((dialog_index + 1), " / ", dialog.size())
		
		##Accessing the dialog of the particular index
		$Content.bbcode_text = dialog[dialog_index]
		$Content.percent_visible = 0
		##T = D/S, Speed = 24
		$Tween.interpolate_property(
			$Content, "percent_visible",
			0.0, 1, (dialog[dialog_index].length()/24) , Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		
	else:
		emit_signal("pop_up_window_finished")
		#queue_free()
	
	dialog_index += 1
	all_finished = 1
	back_button_just_pressed = false
	
	
##Function to show when one dialogue is finished
func _on_Tween_tween_completed(object, key):
	if all_finished == 1:
		finished = true

