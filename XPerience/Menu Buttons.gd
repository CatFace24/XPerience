extends Node2D


func _ready():
	$SettingsWindow.hide()
	$SettingsWindow.set_process_input(false)
	$InfoWindow.hide()
	$InfoWindow.set_process_input(false)
	

func set_menu(stage):
	$Stage.text = stage


func _on_MenuButton_pressed():
	$SettingsWindow/AudioStreamPlayer.play()
	$SettingsWindow.show()
	$SettingsWindow.set_process_input(false)


func _on_InfoButton_pressed():
	$SettingsWindow/AudioStreamPlayer.play()
	$InfoWindow.show()
	$InfoWindow.set_process_input(true)
