extends CharacterBody2D

@onready var spr = get_node('sprite')
@onready var coll = get_node('coll')

const speedx = 300.0
const speedy = 600.0
const fallspd = 49.1
var dir = 1

var animclock = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.


func _ready():
	velocity = Vector2(dir*speedx,-speedy)

func _physics_process(delta):
	velocity.x = dir*speedx
	velocity.y+=fallspd
	move_and_slide()
	if global_position.y>5000:queue_free()
	rotation+=0.1
