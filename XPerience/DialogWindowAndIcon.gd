extends Control

##several parts of a dialog !!! NOT FULL
#var dialog
##order of characters talking, 0 = manager, 1 = PO, 2 = SM, 3 = DEV, 4 = QA, 5 = UX
#var char_speaking 

##This variable needs to recognize how many dialogs there are
#var dialog_index = 0##0 is the first dialog

##This variable stores which character is talking FIRST
#var char_index = 0

##variable to store if the dialogue is finished
var finished = false

##Getting nodes on ready
export (NodePath) var button_path ##script variable in inspector
onready var button = get_node(button_path)


##Reading JSON Dialogue (only parent class)
#export(String, FILE, "*.json") var dialogue_file
var dialog = []
var dialog_index = 0


##function to call text
#func _ready():
	##getting dialogues
	#dialog = load_json()
	#load_dialog()
	#load_icon_and_scene()
	# Create connection for normal button
	#button.connect("pressed", self, "load_convo")


#func load_json(file_path):

	#Passes JSON file and returns it as a dictionary

	#var file = File.new()
	#assert(file.file_exists(file_path))
	
	#if file.file_exists(file_path):
		#file.open(file_path, file.READ)
		#var content = parse_json(file.get_as_text())
		#assert(content.size() > 0)
		#print("\nparsed JSON:")
		#return content

##function to return index
func get_dialog_index():
	return dialog_index

func get_dialog_size():
	#dialog = load_json(dialogue_file)
	#print("\n get dialog size from DialogWindow", dialog.size())
	return dialog.size()

##function for action
func _process(delta):
	$TextureButton.visible = finished

##to be called by current scene
func display_dialog(dialogs):
	#dialog = dialog_array
	#char_speaking = character_order
	dialog = dialogs
	load_dialog()
	#load_icon_and_scene()
	# Create connection for normal button
	button.connect("pressed", self, "load_convo")

##loading both functions to run at the same time
func load_convo():
	load_dialog()
	#load_icon_and_scene()

func load_dialog():
	
	##if dialog index is less than dialog array size, means there is still text
	if dialog_index < dialog.size():
		print("load_dialog and tween")
		load_icon_and_scene()
		finished = false
		##Accessing the dialog of the particular index
		$RichTextLabel.bbcode_text = dialog[dialog_index]["content"]
		$RichTextLabel.percent_visible = 0
		##T = D/S, Speed = 24
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible",
			0, 1, (dialog[dialog_index]["content"].length()/24), Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		#print("tween complete?")
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
	#if char_index < char_speaking.size():
	if dialog_index < dialog.size():
		print("\nload_icon dialog indx: ", dialog_index)
		match dialog[dialog_index]["character"]:
			"Manager":
				reset_icon()
				$ManagerIcon.show()
			
			"Product Owner":
				reset_icon()
				$POIcon.show()
			
			"UX":
				reset_icon()
				$UXIcon.show()
				
			"QA":
				reset_icon()
				$QAIcon.show()
				
			"Scrum Master":
				reset_icon()
				$SMIcon.show()
				
			"Dev":
				reset_icon()
				$DevIcon.show()
		
	else:
		pass
	
	#char_index += 1

##Function to show when one dialogue is finished
func _on_Tween_tween_completed(object, key):
	finished = true

