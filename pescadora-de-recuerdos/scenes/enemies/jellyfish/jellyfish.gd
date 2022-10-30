extends Enemy

var rng=RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	var random= rng.randf_range(1.0,50.0)
	var random_time= rng.randf_range(1.0,6.0)
	var tween:= create_tween().set_loops().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "position:x", random, random_time).as_relative()
	tween.tween_interval(0.5)
	tween.tween_property(self, "position:y", -random, random_time).as_relative()
	tween.tween_interval(0.5)
	tween.tween_property(self, "position:x", -random, random_time).as_relative()
	tween.tween_interval(0.5)
	tween.tween_property(self, "position:y", random, random_time).as_relative()
	tween.tween_interval(0.5)
