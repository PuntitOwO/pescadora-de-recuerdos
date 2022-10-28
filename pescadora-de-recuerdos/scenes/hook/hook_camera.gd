extends Camera2D

export (NodePath) var target_path
var target

func _ready() -> void:
	target = get_node(target_path)

func _physics_process(delta: float) -> void:
	if is_instance_valid(target):
		global_position.y = target.global_position.y
