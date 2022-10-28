extends KinematicBody2D

export var down_velocity = 10.0
export var down_acceleration = 10
export var fast_down_velocity = 100
export var up_velocity = -100.0
export var move_velocity = 100

var velocity := Vector2.ZERO

func _physics_process(_delta: float) -> void:
	velocity.y += down_acceleration
	velocity.x -= down_acceleration * sign(velocity.x)
	velocity.y = clamp(velocity.y, up_velocity, down_velocity)
	if Input.is_action_pressed("move_down"):
		velocity.y = fast_down_velocity
	if Input.is_action_just_pressed("move_left"):
		velocity.y = up_velocity
		velocity.x -= move_velocity
	if Input.is_action_just_pressed("move_right"):
		velocity.y = up_velocity
		velocity.x += move_velocity
	velocity = move_and_slide(velocity, Vector2.UP)
