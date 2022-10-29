extends ColorRect

export (NodePath) var initial_color_pos_path
export (NodePath) var final_color_pos_path
export (NodePath) var target_path
export (Color) var initial_color
export (Color) var final_color

var initial_color_pos
var final_color_pos
var target
var weight = 0.0

func _ready() -> void:
	initial_color_pos = get_node(initial_color_pos_path)
	final_color_pos = get_node(final_color_pos_path)
	target = get_node(target_path)

func _physics_process(_delta: float) -> void:
	weight = (target.global_position.y - initial_color_pos.global_position.y) / (final_color_pos.global_position.y - initial_color_pos.global_position.y)
	weight = clamp(weight, 0.0, 1.0)
	color = initial_color.linear_interpolate(final_color, weight)
