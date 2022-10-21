extends Node2D

export(String) var bus_name
export(String) var scene_to_load
export(NodePath) var audio_stream_player_path

func _ready():
	##getting audio node from global scene
	audio_stream_player_path = $"/root/MainBGM" 
	$ResumeButton.connect("pressed", self, "resume_game")
	$QuitButton.connect("pressed", self, "quit_game")


##function for HSlider value changed
func _on_HSlider_value_changed(value):
	
	##bus_index is useful if u wanna separate music, SFX, etc.
	var bus_index = AudioServer.get_bus_index(bus_name)
	
	if value > $HSlider.min_value:
		AudioServer.set_bus_mute(bus_index, false)
		AudioServer.set_bus_volume_db(bus_index, value)
		
	else:
		AudioServer.set_bus_mute(bus_index, true)
	
	
##funciton to resume game
func resume_game():
	$AudioStreamPlayer.play()
	self.hide()
	self.set_process_input(false)
	

##function to quit game
func quit_game():
	$AudioStreamPlayer.play()
	get_tree().change_scene(scene_to_load)
