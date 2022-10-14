extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$Tween.interpolate_property(
		self, "percent_visible",
		0.0, 1, 6, Tween.TRANS_CUBIC, Tween.EASE_OUT
	)
	$Tween.start()
