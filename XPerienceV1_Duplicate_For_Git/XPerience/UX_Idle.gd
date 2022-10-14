extends Node2D


func _ready():
	pass # Replace with function body.


func switch_sprite():
	$UX_Idle/AnimationPlayer.play("UX_Idle_Chicken")
