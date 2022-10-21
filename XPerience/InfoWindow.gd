extends Node2D


func _ready():
	$TextureButton.connect("pressed", self, "resume_game")


##funciton to resume game
func resume_game():
	$AudioStreamPlayer.play()
	self.hide()
	self.set_process_input(false)
