extends Viewport

const SCROLL_SPEED = 10

func _process(delta: float) -> void:
	$Camera2D.position.y -= delta * SCROLL_SPEED
