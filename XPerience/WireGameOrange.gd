extends Node2D

##variable to see if its dragging
var dragging = false
var click_radius = 30 ##size of sprite
var last_mouse_point
##var to see if its done
var line_connected = false

##signal when line is connected
signal orange_connected


func _ready():
	pass # Replace with function body.


func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if (event.position - $RayCast2D.position).length() < click_radius:
			##Start dragging if the click is on the sprite.
			if not dragging and event.pressed:
				dragging = true
		##Stop dragging if the button is released.
		if dragging and not event.pressed:
			dragging = false


func _process(delta):
	##rotating the raycast towards the cursor and drawing every frame
	$RayCast2D.look_at(get_global_mouse_position())
	update()
	
	if not line_connected:
		if Input.is_action_just_released("click"):
			
			if last_mouse_point == null:
				pass
			
			else:
				if last_mouse_point.x > $LED.position.x - 10 and last_mouse_point.x < $LED.position.x + 10:
					
					if last_mouse_point.y > $LED.position.y - 10 and last_mouse_point.y < $LED.position.y + 10:
						
						##emit some signal here, but need each 'connector' to have their own script
						emit_signal("orange_connected")
						
						if line_connected == false: 
							print(last_mouse_point)
							create_line($RayCast2D.position, $LED.position)
							line_connected = true
						
						if line_connected == true:
							$LED/StaticBody2D/BrightLED.show()
							pass
						
				else:
					pass


##funciton to visualize
func _draw():
	if dragging:
		##Color(r,g,b,a) but the rgba values are normalized to 0-1..instead of 0-155
		draw_circle(get_global_mouse_position(), 5, Color(56/155,57/155,77/155))
		draw_line($RayCast2D.position, get_global_mouse_position(), Color(56/155,57/155,77/155))
		
		last_mouse_point = get_global_mouse_position()


func create_line(from, to):
	print("from: ", from)
	$Line2D.add_point(from)
	$Line2D.add_point(to)
	$Line2D.show()

	
