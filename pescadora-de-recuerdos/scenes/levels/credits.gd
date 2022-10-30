extends Node2D

func _ready() -> void:
	GameManager.fade_fade()
	$PreGameCamera.current = true
	
func _audio_play() -> void:
	$AudioStreamPlayer.play()
