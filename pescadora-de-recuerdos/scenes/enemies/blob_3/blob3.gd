extends Enemy

onready var r_dir_x = $Sprite.material.get_shader_param("r_dir_x")
onready var r_dir_y = $Sprite.material.get_shader_param("r_dir_y")
onready var g_dir_x = $Sprite.material.get_shader_param("g_dir_x")
onready var g_dir_y = $Sprite.material.get_shader_param("g_dir_y")
onready var b_dir_x = $Sprite.material.get_shader_param("b_dir_x")
onready var b_dir_y = $Sprite.material.get_shader_param("b_dir_y")
export var speed = 3.0
export (NodePath) var node_attached_path
var node_attached 
var triggered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$TimerR.connect("timeout",self,"on_TimerR_timeout")
	$TimerG.connect("timeout",self,"on_TimerG_timeout")
	$TimerB.connect("timeout",self,"on_TimerB_timeout")
	node_attached = get_node(node_attached_path)

func on_TimerR_timeout():
	r_dir_x *= -1
	r_dir_y *= -1
	$Sprite.material.set_shader_param("r_dir_x",r_dir_x)
	$Sprite.material.set_shader_param("r_dir_y",r_dir_y)
	
func on_TimerG_timeout():
	g_dir_x *= -1
	g_dir_y *= -1
	$Sprite.material.set_shader_param("g_dir_x",g_dir_x)
	$Sprite.material.set_shader_param("g_dir_y",g_dir_y)
func on_TimerB_timeout():
	b_dir_x *= -1
	b_dir_y *= -1
	$Sprite.material.set_shader_param("b_dir_x",b_dir_x)
	$Sprite.material.set_shader_param("b_dir_y",b_dir_y)

func _physics_process(delta):
	rotation_degrees += 5
	if triggered == true:
		var init_pos = get_position()
		var player_pos = node_attached.global_position
		var direction = (player_pos - init_pos) / sqrt(pow(player_pos[0]-init_pos[0],2)+pow(player_pos[1]-init_pos[1],2))
		position.x +=  direction[0]*speed
		position.y += direction[1]*speed
	elif abs(get_tree().get_nodes_in_group("Hook")[0].global_position[1] - global_position[1]) <= 800:
		triggered = true 
