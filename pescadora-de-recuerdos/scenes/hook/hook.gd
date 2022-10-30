extends KinematicBody2D

export var max_down_velocity = 150.0
export var max_up_velocity = -300.0
export var max_move_velocity = 300.0
export var down_acceleration = 10
export var up_decceleration = 10
export var fast_down_velocity = 150
export var move_velocity = 200
export var knockback_strength = 150
export var bubble_duration = 60
var bubble_time_activated = 0
var velocity := Vector2.ZERO

signal damage

func _ready():
	get_viewport().audio_listener_enable_2d = true
	$bubbles1.emitting = false
	$bubbles2.emitting = false
	
func _physics_process(_delta: float) -> void:
	if velocity.y < 0:
		velocity.y += up_decceleration
	else:
		velocity.y += down_acceleration
	velocity.x -= up_decceleration * sign(velocity.x)
	velocity.y = clamp(velocity.y, max_up_velocity, max_down_velocity)
	if Input.is_action_pressed("move_down") and velocity.y >= 0.0:
		$bubbles1.emitting = true
		$bubbles2.emitting = true
		velocity.y = fast_down_velocity
	if Input.is_action_just_released("move_down"):
		$bubbles1.emitting = false
		$bubbles2.emitting = false
	if Input.is_action_just_pressed("move_left"):
		if bubble_time_activated <= bubble_duration:
			$bubbles1.emitting = true
			$bubbles2.emitting = true
		$hook_pull.play()
		velocity.y = max_up_velocity
		velocity.x -= move_velocity
	if Input.is_action_just_pressed("move_right"):
		if bubble_time_activated <= bubble_duration:
			$bubbles1.emitting = true
		$hook_pull.play()
		velocity.y = max_up_velocity
		velocity.x += move_velocity
	bubble_time_activated+=1
	if bubble_time_activated >= bubble_duration:
		$bubbles1.emitting = false
		$bubbles2.emitting = false
		bubble_time_activated = 0
	velocity.x = clamp(velocity.x, -max_move_velocity, max_move_velocity)
	velocity = move_and_slide(velocity, Vector2.UP)
	#collisions
	for i in get_slide_count():
		var collision := get_slide_collision(i)
		if collision.collider is Collectable:
			var image_index = (collision.collider as Collectable).image_index
			var next_level = (collision.collider as Collectable).next_level
			_collected(collision.collider, image_index, next_level)
			return
			
		if collision.collider is VoidTile or Enemy:
			var knockback_direction = collision.position.direction_to(global_position)
			_knockback(knockback_direction)

func _collected(body:Node2D, image_index:int, next_level:bool) -> void:
	body.queue_free()
	GameManager.show_image(image_index, next_level)

func _knockback(direction:Vector2) -> void:
	$hook_hurt.play()
	emit_signal("damage")
	set_physics_process(false)
	velocity = Vector2.ZERO
	var tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_method(self, "move_and_slide", direction * knockback_strength, Vector2.ZERO, 0.6)
	tween.tween_callback(self, "set_physics_process", [true])
