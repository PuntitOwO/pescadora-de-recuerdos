extends CanvasLayer

export var quantity = 0.0
export var delta_effect = 0.2
export var restitution = 0.05

func _ready() -> void:
	get_tree().get_nodes_in_group("Hook")[0].connect("damage", self, "_on_damage")

func _on_damage() -> void:
	quantity += delta_effect

func _process(delta: float) -> void:
	quantity -= delta * restitution
	quantity = clamp(quantity, 0.0, 1.0)
	$TextureRect.modulate.a = quantity
