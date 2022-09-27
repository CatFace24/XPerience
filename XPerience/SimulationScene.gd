extends Node2D

signal bars_complete

func _ready():
	pass # Replace with function body.
	
func _on_LoadingBars_bars_finished():
	print("Simulation Finished!!")
	emit_signal("bars_complete")
