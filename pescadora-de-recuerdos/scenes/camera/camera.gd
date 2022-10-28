extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (NodePath) var node_attached_path
var node_attached 

# Called when the node enters the scene tree for the first time.
func _ready():
	node_attached = get_node(node_attached_path)
	set_position(Vector2(0,node_attached.global_position[0]))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_position(Vector2(0,node_attached.global_position[0]))
#	pass
