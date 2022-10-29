extends Node

signal input

export (Array, Texture) var images

func _ready() -> void:
	set_process(false)

## Takes screenshot and sets it as texture of Screenshot child
func screenshot() -> void:
	var img = get_viewport().get_texture().get_data()
	img.flip_y()
	var sc = ImageTexture.new()
	sc.create_from_image(img)
	$"%Screenshot".texture = sc

## Shows image using two interpolations at the same time:
## 1. shows screenshot and pixelates it as it fade to transparent black
## 2. shows image and fade it from transparent to fully visible
func blur_and_fade_image_in() -> void:
	get_tree().paused = true
	screenshot()
	$"%Screenshot".show()
	$"%Image".show()
	var tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT).set_parallel(true)
	tween.tween_property($"%Screenshot".material, "shader_param/pixel_factor", 0.1, 1.0)
	tween.tween_property($"%Screenshot", "modulate", Color(0.0,0.0,0.0,1.0), 2.0)
	tween.tween_property($"%Image", "modulate:a", 1.0, 2.0)

## Reverses the interpolations made in blur_and_fade_image_in
func unblur_and_fade_image_out() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN).set_parallel(true)
	tween.tween_property($"%Screenshot".material, "shader_param/pixel_factor", 1.0, 2.0)
	tween.tween_property($"%Screenshot", "modulate", Color(1.0,1.0,1.0,1.0), 1.0)
	tween.tween_property($"%Image", "modulate:a", 0.0, 1.0)
	tween.chain().tween_callback($"%Screenshot", "hide")
	tween.chain().tween_callback($"%Image", "hide")
	tween.chain().tween_callback(get_tree(), "set_pause", [false])

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_select") or Input.is_action_just_pressed("ui_accept"):
		emit_signal("input")

func show_image(image_index: int) -> void:
	$"%Image".texture = images[image_index]
	blur_and_fade_image_in()
	set_process(true)
	yield(self, "input")
	set_process(false)
	unblur_and_fade_image_out()
	$"%Image".hide()

func _unhandled_key_input(event: InputEventKey) -> void:
	if event.pressed and not event.echo:
		if event.scancode == KEY_1:
			show_image(0)
		if event.scancode == KEY_2:
			show_image(1)
		
