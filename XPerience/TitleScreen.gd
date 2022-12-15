extends Control

var scene_path_to_load

func _ready():
	##Setting empty menu text
	$MenuButtons.set_menu(" ")
	##Connecting button signals to this node
	##For the children buttons in this menu
	for button in $CenterRow/Button.get_children():
		##Connect the pressed event to this node ('self'), and call this function ('_on_button_pressed')
		##And to load which scene
		print("button exists")
		print($CenterRow/Button.get_children())
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
				

func _on_Button_pressed(scene_to_load):
	print("button pressed")
	$CenterRow/Button/TextureButton/AudioStreamPlayer.play()
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()


##connecting from the signal
func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_path_to_load)
