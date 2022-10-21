extends Node2D

func _ready():
	##getting animation player
	$AnimationPlayer.play("MeetingRoom")


func normal_meeting_room():
	$ColorRect.hide()
	$NotRetro.show()
	$Retro.hide()
	$AnimationPlayer.play("NotRetroMeetingRoom")

