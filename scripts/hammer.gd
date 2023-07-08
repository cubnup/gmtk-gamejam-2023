extends CharacterBody2D

@onready var spr = get_node('sprite')
@onready var coll = get_node('coll')

var speedx = 200.0
var speedy = 400.0
var fallspd = 39.2
var dir = 1
var mult = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.


func _ready():
	velocity += Vector2(dir*speedx,-speedy*mult)
#	fallspd /= rng
	

func _physics_process(delta):
	velocity.x = dir*speedx
	velocity.y+=fallspd
	if move_and_slide():
		for i in get_slide_collision_count():
			var manto = get_slide_collision(i).get_collider()
			manto.fuckingdie()
			queue_free()
	if global_position.y>5000:queue_free()
	rotation+=0.1
