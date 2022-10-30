extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 3.0
export (NodePath) var node_attached_path
var node_attached 
# Called when the node enters the scene tree for the first time.
func _ready():
	node_attached = get_node(node_attached_path)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var init_pos = get_position()
	var player_pos = node_attached.global_position
	var direction = (player_pos - init_pos) / sqrt(pow(player_pos[0]-init_pos[0],2)+pow(player_pos[1]-init_pos[1],2))
	position.x +=  direction[0]*speed
	position.y += direction[1]*speed
