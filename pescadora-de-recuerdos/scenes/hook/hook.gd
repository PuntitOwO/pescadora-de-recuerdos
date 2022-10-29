extends KinematicBody2D

export var max_down_velocity = 150.0
export var max_up_velocity = -300.0
export var max_move_velocity = 300.0
export var down_acceleration = 10
export var up_decceleration = 10
export var fast_down_velocity = 150
export var move_velocity = 200
export var knockback_strength = 150

var velocity := Vector2.ZERO

func _physics_process(_delta: float) -> void:
	if velocity.y < 0:
		velocity.y += up_decceleration
	else:
		velocity.y += down_acceleration
	velocity.x -= up_decceleration * sign(velocity.x)
	velocity.y = clamp(velocity.y, max_up_velocity, max_down_velocity)
	if Input.is_action_pressed("move_down") and velocity.y >= 0.0:
		velocity.y = fast_down_velocity
	if Input.is_action_just_pressed("move_left"):
		velocity.y = max_up_velocity
		velocity.x -= move_velocity
	if Input.is_action_just_pressed("move_right"):
		velocity.y = max_up_velocity
		velocity.x += move_velocity
	velocity.x = clamp(velocity.x, -max_move_velocity, max_move_velocity)
	velocity = move_and_slide(velocity, Vector2.UP)
	#collisions
	for i in get_slide_count():
		var collision := get_slide_collision(i)
		if collision.collider is VoidTile:
			var knockback_direction = collision.position.direction_to(global_position)
			_knockback(knockback_direction)

func _knockback(direction:Vector2) -> void:
	set_physics_process(false)
	velocity = Vector2.ZERO
	var tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_method(self, "move_and_slide", direction * knockback_strength, Vector2.ZERO, 0.6)
	tween.tween_callback(self, "set_physics_process", [true])
