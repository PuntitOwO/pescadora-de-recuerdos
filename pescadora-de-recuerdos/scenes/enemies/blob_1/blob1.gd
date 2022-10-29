extends Enemy

onready var r_dir_x = $Sprite.material.get_shader_param("r_dir_x")
onready var r_dir_y = $Sprite.material.get_shader_param("r_dir_y")
onready var g_dir_x = $Sprite.material.get_shader_param("g_dir_x")
onready var g_dir_y = $Sprite.material.get_shader_param("g_dir_y")
onready var b_dir_x = $Sprite.material.get_shader_param("b_dir_x")
onready var b_dir_y = $Sprite.material.get_shader_param("b_dir_y")

# Called when the node enters the scene tree for the first time.
func _ready():
	$TimerR.connect("timeout",self,"on_TimerR_timeout")
	$TimerG.connect("timeout",self,"on_TimerG_timeout")
	$TimerB.connect("timeout",self,"on_TimerB_timeout")

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
