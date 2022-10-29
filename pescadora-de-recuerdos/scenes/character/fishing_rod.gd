extends Node2D

func start_animation(animation_name:String) -> void:
	$AnimationPlayer.play(animation_name)
