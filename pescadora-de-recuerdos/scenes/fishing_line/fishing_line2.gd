extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (NodePath) var end_node_attached_path
var end_node_attached 
export (NodePath) var start_node_attached_path
var start_node_attached
var y_distance
var x_dir
var point_pos
var points_number
export var restitution_vel = 0.1
# Called when the node enters the scene tree for the first time.
func _ready():
	start_node_attached = get_node(start_node_attached_path)
	end_node_attached = get_node(end_node_attached_path)
	y_distance = end_node_attached.global_position[1] - start_node_attached.global_position[1] 
	$Line2D.set_as_toplevel(true)
	points_number = $Line2D.get_point_count() - 1
	for i in range(1,points_number):
		$Line2D.set_point_position(i,Vector2(end_node_attached.global_position[0], start_node_attached.global_position[1] + y_distance * i/points_number))
	$Line2D.set_point_position(0,start_node_attached.global_position)
	$Line2D.set_point_position(points_number,end_node_attached.global_position)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	#for i in range(1,points_number):
	#	y_distance = end_node_attached.global_position[1] - start_node_attached.global_position[1] 
	#	x_dir = sign(end_node_attached.global_position[0] - $Line2D.get_point_position(i)[0])
	#	point_pos = $Line2D.get_point_position(i)
	#	$Line2D.set_point_position(i,Vector2(point_pos[0] + x_dir*restitution_vel*pow(i,1.2)/points_number, start_node_attached.global_position[1] + y_distance * i/points_number))
	#$Line2D.set_point_position(0,start_node_attached.global_position)
	#$Line2D.set_point_position(points_number,end_node_attached.global_position)
	for i in range(1,points_number):
		y_distance = end_node_attached.global_position[1] - start_node_attached.global_position[1] 
		x_dir = $Line2D.get_point_position(i+1)[0] - $Line2D.get_point_position(i)[0]
		point_pos = $Line2D.get_point_position(i)
		$Line2D.set_point_position(i,Vector2(point_pos[0] + x_dir * restitution_vel * sqrt(i)/20, start_node_attached.global_position[1] + y_distance * i/points_number))
	$Line2D.set_point_position(0,start_node_attached.global_position)
	$Line2D.set_point_position(points_number,end_node_attached.global_position)
