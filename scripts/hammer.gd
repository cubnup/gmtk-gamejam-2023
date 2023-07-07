extends CharacterBody2D

@onready var spr = get_node('sprite')
@onready var coll = get_node('coll')

const speedx = 300.0
const speedy = 600.0
var fallspd = 49.2
var dir = 1
var mult = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.


func _ready():
	var rng = 0.8*float(RandomNumberGenerator.new().randi_range(5,8))/6
	velocity = Vector2(dir*speedx,-speedy*rng+mult*5)
	fallspd /= rng
	

func _physics_process(delta):
	velocity.x = dir*speedx*mult
	velocity.y+=fallspd
	if move_and_slide():
		for i in get_slide_collision_count():
			var manto = get_slide_collision(i).get_collider()
			manto.fuckingdie()
	if global_position.y>5000:queue_free()
	rotation+=0.1
