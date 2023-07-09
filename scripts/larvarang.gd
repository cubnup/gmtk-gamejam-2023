extends CharacterBody2D

@onready var spr = get_node('sprite')
@onready var coll = get_node('coll')

var speedx = 200.0
var speedy = 0.0
var fallspd = 39.2
var dir = 1
var mult = 1
var lifetime = 0.0
var score = 0

var animclock=0

# Get the gravity from the project settings to be synced with RigidBody nodes.


func _ready():
	velocity += Vector2(dir*speedx,-speedy*mult)
#	fallspd /= rng
	

func _physics_process(delta):
	
	animclock = (animclock+1)%12
	
	lifetime+=0.05
	score+=2
	if lifetime>=9:queue_free()
	velocity.x = 3*dir*speedx*cos(lifetime)
	velocity.y=sign(global.bro.global_position.y-global_position.y)*50
	if move_and_slide():
		for i in get_slide_collision_count():
			var manto = get_slide_collision(i).get_collider()
			if manto.has_method('fuckingdie'): 
				manto.fuckingdie()
				global.score+=score
				score+=200
	if global_position.y>5000:queue_free()
	rotation+=180 if animclock>5 else 0
