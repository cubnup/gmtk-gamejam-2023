extends Node2D

@onready var spr = get_node('sprite')
@onready var global = get_node('/root/global')


var speed = 90
var accel = 3


var gravity = 49.1
var normalg = 29.1
var jumpg = 8.1
var fallg = 69.2
var animclock = 0
var dir = -1

var target
var targets = []
var targeti = 0
var targetclock = 0
var targetswitch = 70
var rng
var index = 0
var followdist = 30
const fardist = 700
var state = 0

var doclimb = false

func _ready():
	target = global.bro
	rng = RandomNumberGenerator.new()
	targetclock = rng.randi_range(0,targetswitch)
	global_position=global.flower.global_position+Vector2.UP*30
	

func _physics_process(delta): 
	followdist=10*(index+1)
	
#	if is_on_floor():
#		jump()
	
	var dist = global_position.distance_to(global.bro.global_position)
#		state = 2
	if dist>=followdist:
		state = 1
	else:
		state = 0
		
	state = 1
	match state:
		0:
			pass
		1:
			global_position=global_position.lerp(global.bro.global_position-(global.bro.global_position-global_position).normalized()*followdist,0.2)
			look_at(global.bro.global_position)
	
	spr.frame = global.bro.throwtype


func jump():
	pass
#	velocity.y=-300

