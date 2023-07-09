extends CharacterBody2D

@onready var spr = get_node('sprite')
@onready var coll = get_node('coll')
@onready var hit = preload('res://scenes/hit.tscn')


var speedx = 200.0
var speedy = 400.0
var fallspd = 39.2
var dir = 1
var mult = 1
var score = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.


func _ready():
	score = 1
	velocity += Vector2(dir*speedx,-speedy*mult)
#	fallspd /= rng
	

func _physics_process(delta):
	velocity.x = dir*abs(speedx)
	velocity.y+=fallspd
	score+=1
	if move_and_slide():
		for i in get_slide_collision_count():
			var manto = get_slide_collision(i).get_collider()
			var h = hit.instantiate()
			h.global_position=manto.global_position
			h.emitting = true
			h.speedx=manto.velocity.x*delta
			velocity.y=-speedy
#			set_collision_mask_value(2,false)
			if manto.has_method('fuckingdie'): 
				score+=100
				manto.fuckingdie(score)
			get_tree().get_root().add_child(h)
	if global_position.y>5000:queue_free()
	rotation+=0.1
