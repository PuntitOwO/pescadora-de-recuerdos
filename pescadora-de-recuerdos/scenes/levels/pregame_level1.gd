extends Node2D

signal input

func _ready() -> void:
	get_tree().paused = true
	

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("move_down") or Input.is_action_just_pressed("move_left") or \
		Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("ui_select") or \
		Input.is_action_just_pressed("ui_accept"):
			# TODO: play animation
			$AnimationPlayer.play("StartScene")
			# deactivate process
			set_process(false)

func _start_game() -> void:
	get_tree().paused = false
