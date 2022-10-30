extends Node2D

func _ready() -> void:
	GameManager.fade_fade()
	get_tree().paused = true
	$PreGameCamera.current = true
	

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("move_down") or Input.is_action_just_pressed("move_left") or \
		Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("ui_select") or \
		Input.is_action_just_pressed("ui_accept"):
			$AnimationPlayer.play("StartScene")
			set_process(false)

func _audio_play() -> void:
	$AudioStreamPlayer.play()

func _start_game() -> void:
	get_tree().paused = false
