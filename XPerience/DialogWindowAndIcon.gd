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

##ready var playerchoices
onready var player_option_box = $PlayerChoices/VBoxContainer

var option = false

##Reading JSON Dialogue
#export(String, FILE, "*.json") var dialogue_file
var dialog = []
var dialog_index = 0

##function to call text
#func _ready():
	##getting dialogues
	#$PlayerChoices.hide()
	#dialog = load_json()
	#load_dialog()
	#load_icon_and_scene()
	# Create connection for normal button
	#button.connect("pressed", self, "load_convo")
	
func display_player_options():
	option = true
	$PlayerChoices.visible = true
	$TextureButton.visible = false
	###ITS WORKING but need to set a function to toggle it on and off whenever 'options' are present
	##setting up player choices by removing all child instances
	for child in player_option_box.get_children():
		child.queue_free()
		
	for option in dialog[str(dialog_index)].options:
		#print("Options: ", option)
		var font = DynamicFont.new()
		font.font_data = load("res://Font/quaver.ttf")
		
		var btn = TextureButton.new()
		#btn.underline = LinkButton.UNDERLINE_MODE_ON_HOVER
		#btn.font_color = Color()
		#btn.text = option.text
		#btn.set("custom_fonts/font", font)
		btn.size_flags_horizontal = SIZE_EXPAND_FILL
		btn.size_flags_vertical = 0
		
		var btn_texture_normal = preload("res://UI/Dialogue/Dialog Choice.png")
		var btn_texture_pressed = preload("res://UI/Dialogue/Dialog Choice pressed.png")
		
		var text = RichTextLabel.new()
		##to allow player to press the button
		text.mouse_filter = Control.MOUSE_FILTER_IGNORE
		text.set_anchors_and_margins_preset(Control.PRESET_WIDE)
		text.bbcode_text = option.text
		
		text.margin_bottom = -10
		text.margin_top = 20
		text.margin_right = -10
		text.margin_left = 15
	
		player_option_box.add_child(btn)
		
		text.add_font_override("normal_font", font)
		btn.add_child(text)

		yield(get_tree(), "idle_frame")
		print("text size: ", text.rect_size)
		#print("expand, ", btn.get_expand())
		#print("\nstretch, ", btn.get_stretch_mode())
		print("text: ", text)
		print("text get content height ", text.get_content_height())
		print("text rect_size y ", text.rect_size.y)
		
		btn.rect_min_size.y = text.get_content_height() + 30
		#btn.rect_min_size.y = 200
		btn.rect_min_size.x = 200
		btn.set_expand(true)
		#btn.set_stretch_mode(1)
		btn.set_normal_texture(btn_texture_normal)
		btn.set_hover_texture(btn_texture_pressed)
		##connecting button to function
		btn.connect("pressed", self, "_on_PlayerOptionButton_pressed", [option.next])
		
		
##function for when a player option is pressed
func _on_PlayerOptionButton_pressed(next):
	print("\nPlayerOptionButton_pressed worked")
	dialog_index = next.to_int()
	print("\nNext dialog_index: ", dialog_index)
	load_dialog()

#func load_json():

	#Passes JSON file and returns it as a dictionary
	#var file = File.new()
	#assert(file.file_exists(dialogue_file))
	
	#if file.file_exists(dialogue_file):
		#file.open(dialogue_file, file.READ)
		#var content = parse_json(file.get_as_text())
		#assert(content.size() > 0)
		#return content

##function to return index
func get_dialog_index():
	return dialog_index

##function for action
func _process(delta):
	if option == false:
		$TextureButton.visible = finished
	else:
		$TextureButton.hide()

##to be called by current scene
func display_dialog(dialog_json):
	#dialog = dialog_json
	#char_speaking = character_order
	
	#load_dialog()
	#load_icon_and_scene()
	# Create connection for normal button
	#button.connect("pressed", self, "load_convo")
	##getting dialogues
	$PlayerChoices.hide()
	dialog = dialog_json
	load_dialog()
	#load_icon_and_scene()
	# Create connection for normal button
	button.connect("pressed", self, "load_convo")

##loading both functions to run at the same time
func load_convo():
	load_dialog()
	#load_icon_and_scene()

func load_dialog():
	option = false
	$PlayerChoices.hide()
	##if dialog index is less than dialog array size, means there is still text
	if dialog_index < dialog.size():
		load_icon_and_scene()
		finished = false
		##Accessing the dialog of the particular index
		$RichTextLabel.bbcode_text = dialog[str(dialog_index)]["content"]
		$RichTextLabel.percent_visible = 0
		##T = D/S, Speed = 24
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible",
			0.0, 1, (dialog[str(dialog_index)]["content"].length()/24) , Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
	
		if dialog[str(dialog_index)].has("options"):
			display_player_options()
		
	else:
		queue_free() ##safely DESTROYS the node
	

	if dialog_index != (dialog.size() - 1) and dialog_index < dialog.size():
		if dialog[str(dialog_index)].has("next"):
			dialog_index = dialog[str(dialog_index)]["next"].to_int()
		
	else: 
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
		match dialog[str(dialog_index)]["character"]:
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
	

##Function to show when one dialogue is finished
func _on_Tween_tween_completed(object, key):
	finished = true

