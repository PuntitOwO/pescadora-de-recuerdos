extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (NodePath) var node_attached_path
var node_attached 
# Called when the node enters the scene tree for the first time.
func _ready():
	node_attached = get_node(node_attached_path)
	$Line2D.set_as_toplevel(true)
	$Line2D.set_point_position(0,Vector2(0,-200))
	$Line2D.set_point_position(1,node_attached.global_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$Line2D.set_point_position(1,node_attached.global_position)
#	pass
