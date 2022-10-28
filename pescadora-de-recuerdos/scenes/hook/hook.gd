extends KinematicBody2D

export var down_velocity = 10.0
export var down_acceleration = 0.3
export var up_velocity = 10.0

var velocity := Vector2.ZERO

func _physics_process(_delta: float) -> void:
	if velocity.y < 10:
		velocity.y += down_acceleration
	velocity = move_and_slide(velocity, Vector2.UP)
