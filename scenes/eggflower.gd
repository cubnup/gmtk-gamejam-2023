extends CharacterBody2D

@onready var spr = get_node('sprite')
@onready var coll = get_node('coll')
@onready var rc = get_node('rc')
#@onready var ln = get_node('ln')

var speedx = 400.0
var speedy = 0.0
var fallspd = 3.92
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
	rc.target_position = Vector2.RIGHT*dir*30
	animclock = (animclock+1)%12
	
	lifetime+=0.05
	
	if lifetime>=9:queue_free()
	if rc.is_colliding():
		print('-1')
		dir*=-1
	velocity.x = dir*abs(speedx)
	velocity.y= lerp(velocity.y,abs(speedx*2.5),0.1)
	if is_on_floor():
		velocity.y=-900
	if move_and_slide():
		for i in get_slide_collision_count():
			var manto = get_slide_collision(i).get_collider()
			if manto.has_method('fuckingdie'): 
				manto.fuckingdie()
				global.score+=1
				queue_free()
	if global_position.y>5000:queue_free()
	spr.rotation+=180 if animclock>5 else 0
