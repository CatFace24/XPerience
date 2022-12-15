extends Control


func _ready():
	$MenuButtons.set_menu("ENDING - RETROSPECTIVE")


func _on_EndingAndRetroDialog_hide_stage():
	$MenuButtons.hide_stage()
