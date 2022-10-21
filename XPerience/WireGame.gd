extends Node2D

##signal for all connected
signal all_connected

var orange = false
var red = false
var teal = false
var purple = false

var no_connected = 0

func _ready():
	pass


func _on_Orange_orange_connected():
	orange = true
	is_all_connected()
	$Orange.set_process_input(false)


func _on_Red_red_connected():
	red = true
	is_all_connected()
	$Red.set_process_input(false)


func _on_PurpleGrey_purple_connected():
	purple = true
	is_all_connected()
	$PurpleGrey.set_process_input(false)


func _on_Teal_teal_connected():
	teal = true
	is_all_connected()
	$Teal.set_process_input(false)


func is_all_connected():

	if orange and red and purple and teal:
		emit_signal("all_connected")
		$PurpleGrey.set_process_input(false)
		$Red.set_process_input(false)
		$Teal.set_process_input(false)
		$Orange.set_process_input(false)
		

func persona_completed():
	$EmptyPersona.hide()
	$EmptyPersonaContent.hide()
	$Caption.hide()
	$CompletedPersona.show()
	$CompletedPersonaContent.show()
	$CompletedCaption.show()
