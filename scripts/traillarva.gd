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

var which = 0 

var doclimb = false

func _ready():
	target = global.bro
	rng = RandomNumberGenerator.new()
	targetclock = rng.randi_range(0,targetswitch)
	

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
	
	var rng = RandomNumberGenerator.new()
	var rngv = Vector2.ZERO
	rng.randomize()
	rngv.x = randf_range(-5,5)
	rng.randomize()
	rngv.y = randf_range(-5,5)
	state = 1
	match state:
		0:
			pass
		1:
			global_position=global_position.lerp(global.bro.global_position-(global.bro.global_position-global_position+rngv*5).normalized()*followdist,0.1)
			look_at(global.bro.global_position)
	


func jump():
	pass
#	velocity.y=-300

