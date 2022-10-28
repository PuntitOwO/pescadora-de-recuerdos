extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (NodePath) var end_node_attached_path
var end_node_attached 
export (NodePath) var start_node_attached_path
var start_node_attached 
# Called when the node enters the scene tree for the first time.
func _ready():
	start_node_attached = get_node(start_node_attached_path)
	end_node_attached = get_node(end_node_attached_path)
	$Line2D.set_as_toplevel(true)
	$Line2D.set_point_position(0,start_node_attached.global_position)
	$Line2D.set_point_position(1,end_node_attached.global_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$Line2D.set_point_position(0,start_node_attached.global_position)
	$Line2D.set_point_position(1,end_node_attached.global_position)
	
#	pass
