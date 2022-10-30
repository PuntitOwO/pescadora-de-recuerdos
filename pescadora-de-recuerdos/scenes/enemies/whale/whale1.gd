extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player_near = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	$CollisionShape2D.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if abs(get_tree().get_nodes_in_group("Hook")[0].global_position[1] - global_position[1]) <= 500:
		player_near = true 
	if player_near == true:
		global_position[0] -= 50 * delta * sign(scale[0])
