extends Enemy


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var time = 3.0
export var interval = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	var tween:= create_tween().set_loops().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "position:x", -1250*sign(scale[0]),time).as_relative()
	tween.tween_interval(interval)
	tween.tween_callback(self, "flip_x")
	tween.tween_property(self, "position:x", 1250*sign(scale[0]),time).as_relative()
	tween.tween_interval(interval)
	tween.tween_callback(self, "flip_x")
	
func flip_x():
	scale[0] *= -1

