extends Node2D

signal int_complete

func _ready():
	$TestingProgress/HappyUser.hide()
	$TestingProgress/AnimationPlayer.play("TestingProgress")

func _on_TestingProgress_int_finished():
	$TestingProgress/HappyUser.show()
	$TestingProgress/HappyUser/AnimationPlayer.play("HappyUser")
	get_tree().create_timer(3.5).connect("timeout", self, "delay_animation")
	
func delay_animation():
	emit_signal("int_complete")
