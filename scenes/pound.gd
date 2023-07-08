extends CharacterBody2D

@onready var spr = get_node('sprite')
@onready var coll = get_node('coll')

var speedx = 400.0
var speedy = 0.0
var fallspd = 39.2
var dir = 1
var mult = 1
var lifetime = 0.0
var score = 0

var animclock=0

# Get the gravity from the project settings to be synced with RigidBody nodes.


func _ready():
	velocity += Vector2(dir*speedx,speedy*mult)
#	fallspd /= rng
	

func _physics_process(delta):
	velocity.y+=fallspd
	if is_on_floor():
		queue_free()
		
	if global_position.y>5000:queue_free()
	move_and_slide()
