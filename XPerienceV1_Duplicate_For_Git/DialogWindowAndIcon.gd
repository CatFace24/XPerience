extends Control

##several parts of a dialog !!! NOT FULL
var dialog
##order of characters talking, 0 = manager, 1 = PO, 2 = SM, 3 = DEV, 4 = QA, 5 = UX
var char_speaking 

##This variable needs to recognize how many dialogs there are
var dialog_index = 0##0 is the first dialog

##This variable stores which character is talking FIRST
var char_index = 0

##variable to store if the dialogue is finished
var finished = false

##Getting nodes on ready
export (NodePath) var button_path ##script variable in inspector
onready var button = get_node(button_path)

##function to call text
#func _ready():
	#load_dialog()
	#load_icon_and_scene()
	# Create connection for normal button
	#button.connect("pressed", self, "load_convo")
	
##function to return index
func get_dialog_index():
	return dialog_index

##function for action
func _process(delta):
	$TextureButton.visible = finished


##to be called by current scene
func display_dialog(dialog_array, character_order):
	dialog = dialog_array
	char_speaking = character_order
	
	load_dialog()
	load_icon_and_scene()
	# Create connection for normal button
	button.connect("pressed", self, "load_convo")

##loading both functions to run at the same time
func load_convo():
	load_dialog()
	load_icon_and_scene()

func load_dialog():
	
	##if dialog index is less than dialog array size, means there is still text
	if dialog_index < dialog.size():
		finished = false
		##Accessing the dialog of the particular index
		$RichTextLabel.bbcode_text = dialog[dialog_index]
		$RichTextLabel.percent_visible = 0
		##T = D/S, Speed = 24
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible",
			0.0, 1, (dialog[dialog_index].length()/24) , Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
	
	else:
		queue_free() ##safely DESTROYS the node
	
	dialog_index += 1


##function to hide all icons
func reset_icon():
	$UXIcon.hide()
	$SMIcon.hide()
	$QAIcon.hide()
	$DevIcon.hide()
	$ManagerIcon.hide()
	$POIcon.hide()

##function to load speaker's icon
func load_icon_and_scene():
## 0 = manager, 1 = PO, 2 = SM, 3 = DEV, 4 = QA, 5 = UX
	if char_index < char_speaking.size():
		##Accessing the character of the particular index
		if char_speaking[char_index] == 0:
			reset_icon()
			$ManagerIcon.show()

		elif char_speaking[char_index] == 1:
			reset_icon()
			$POIcon.show()
			
		elif char_speaking[char_index] == 2:
			reset_icon()
			$SMIcon.show()
		
		elif char_speaking[char_index] == 3:
			reset_icon()
			$DevIcon.show()
			
		elif char_speaking[char_index] == 4:
			reset_icon()
			$QAIcon.show()
			
		elif char_speaking[char_index] == 5:
			reset_icon()
			$UXIcon.show()

		
	else:
		pass
	
	char_index += 1

##Function to show when one dialogue is finished
func _on_Tween_tween_completed(object, key):
	finished = true

