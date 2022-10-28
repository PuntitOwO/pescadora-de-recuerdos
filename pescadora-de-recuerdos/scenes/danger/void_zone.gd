extends Area2D

func _ready() -> void:
	$CollisionPolygon2D.polygon = $Polygon2D.polygon
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Hook"):
		print("ewe")
	else:
		print("unu")
