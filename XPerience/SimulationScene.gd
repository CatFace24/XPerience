extends Node2D

signal bars_complete


func _on_LoadingBars_bars_finished():
	$CompletedSound.play()
	emit_signal("bars_complete")
	

func play_ux_interview():
	$YSort/UX_Static.ux_interview()
