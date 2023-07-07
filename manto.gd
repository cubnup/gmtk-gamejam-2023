extends CharacterBody2D

@onready var spr = get_node('sprite')
@onready var coll = get_node('coll')
@onready var rc = get_node('rc')
@onready var larva = preload("res://scenes/larva.tscn")
@onready var global = get_node('/root/global')


var speed = 90
var accel = 3

var jumpstate = 0
var jumpmint = 5
var jumpmaxt = 80
var jumpclock = 0

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
var targetswitch = 120

var doclimb = false

func _ready():
	target = global.bro
	pass

func _physics_process(delta): 
	targets = [global.bro,global.flower,global.flower]
	var rng = RandomNumberGenerator.new()
	targetclock+=1
	
	rc.target_position=Vector2(sign(velocity.x)*50,0)
	
	
	velocity.x = clampf(velocity.x,-speed,speed)
	
	global.lbar.text+=str(targeti)
	if is_on_floor() and (rc.is_colliding() or rng.randf_range(0,1)>0.99) and targeti!=2:
		jump()
#
#	if move_and_slide():
#		for i in get_slide_collision_count():
#			var point = get_slide_collision(i).get_collider()
#			velocity+=(point.global_position-global_position)*0.1
	animclock = (animclock+1)%24
	if Input.is_action_just_pressed("reload"):get_tree().reload_current_scene()
	animclock = (animclock+1)%12
	

	if is_on_floor():
		jumpstate=1
		spr.frame = 0 if animclock>5 else 1
#		jump()
	if jumpclock>0:
		jumpclock-=1
	if jumpclock==0 and !is_on_floor():
		jumpstate=0
	match jumpstate:
		0:
			gravity = fallg
			spr.frame = 3
		1:
			gravity = normalg
		2:
			gravity = jumpg
			spr.frame = 2
	

	if rng.randi_range(0,targetclock)>targetswitch:
		targeti=rng.randi_range(0,2)
		targetclock=0
	if targeti == 0:
		rng.randomize ( )
		velocity.x-=sign(global.bro.position.x-global_position.x) *rng.randf_range(0,1)
		rng.randomize ( )
		velocity.x-=sign(global.flower.position.x-global_position.x) *rng.randf_range(0,2)
	elif targeti == 1:
		rng.randomize ( )
		velocity.x+=sign(global.bro.position.x-global_position.x) *rng.randf_range(0,1)
		rng.randomize ( )
		velocity.x+=sign(global.flower.position.x-global_position.x) *rng.randf_range(0,1)
	else:
		spr.frame = 4
		velocity.x=0
		
	if not is_on_floor(): velocity.y+=gravity
	
	if doclimb: 
		velocity=Vector2.UP*10
		spr.frame=2
	move_and_slide()


func jump():
	jumpstate = 2
	var rng = RandomNumberGenerator.new()
	velocity.y=-rng.randf_range(30,230)
	jumpclock= rng.randi_range(jumpmint,jumpmaxt)

func climb():
	doclimb=true

func fuckingdie():
	queue_free()
