extends Node2D

onready var dev1 = get_node("Dev1")
onready var dev2 = get_node("Dev2")
onready var qa = get_node("QA")
onready var sm = get_node("ScrumMaster")
onready var ux = get_node("UXDesigner")

##following index order, SM, Dev(s), QA, UX
var index = 0

func _ready():
	pass # Replace with function body.


func reset_icon_scale():
	##nodes
	dev1.scale = Vector2(3,3)
	dev2.scale = Vector2(3,3)
	qa.scale = Vector2(3,3)
	sm.scale = Vector2(3,3)
	ux.scale = Vector2(3,3)
	
func reset_font_position():
	$DEV1.rect_position.y = 300
	$DEV2.rect_position.y = 300
	$QA2.rect_position.y = 300
	$SM.rect_position.y = 300
	$UX.rect_position.y = 300


func scale_icon():
	if index == 0:
		reset_icon_scale()
		reset_font_position()
		sm.scale = Vector2(4,4)
		$SM.rect_position.y = 320
		index += 1
		
	elif index == 1:
		reset_icon_scale()
		reset_font_position()
		dev1.scale = Vector2(4,4)
		dev2.scale = Vector2(4,4)
		$DEV1.rect_position.y = 320
		$DEV2.rect_position.y = 320
		index += 1
		
	elif index == 2:
		reset_icon_scale()
		reset_font_position()
		qa.scale = Vector2(4,4)
		$QA2.rect_position.y = 320
		index += 1
		
	elif index == 3:
		reset_icon_scale()
		reset_font_position()
		$UXDesigner.scale = Vector2(4,4)
		$UX.rect_position.y = 320
		index += 1
		
	else:
		reset_icon_scale()
		reset_font_position()

