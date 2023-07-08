extends CharacterBody2D

@onready var spr = get_node('sprite')
@onready var coll = get_node('coll')
@onready var rc = get_node('rc')
@onready var rc2 = get_node('rc2')
@onready var larva = preload("res://scenes/larva.tscn")
@onready var global = get_node('/root/global')


var speed = 50
var sprspeed = 300
var accel = 15

var jumpstate = 0
var jumpmint = 5
var jumpmaxt = 30
var jumpclock = 0

var gravity = 49.1
var normalg = 29.1
var jumpg = 8.1
var fallg = 69.2
var animclock = 0

var target
var targets = []
var targeti = 0
var targetclock = 0
var targetswitch = 70
var rng

var dir = 1
var sprinting = false
var crouching = false

var doclimb = false


var sprintclock = 0

func _physics_process(delta): 
	if global_position.x>global.flower.global_position.x+50: dir=-1
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	sprintclock+=rng.randi_range(0,5)
	if sprintclock>240:
		sprintclock=0
		sprinting = !sprinting
	
	dir+=0.01*sign(global.flower.global_position.x-global_position.x)
	dir = clampf(dir,-1,1)
	
	if dir!=0:spr.scale.x=-sign(dir)
	animclock = (animclock+1)%12
	rng = RandomNumberGenerator.new()
	rng.randomize()
	if targetclock==0: targeti=rng.randi_range(0,2)
	targetclock+=1
	
	rc.target_position=Vector2(sign(velocity.x)*50,0)
	
	
	
	rng.randomize()
	if is_on_floor() and ((rc.is_colliding() and rng.randf_range(0,1)>0.9) or rng.randf_range(0,1)>0.9):
		jump()
	if is_on_floor() and ((rc.is_colliding() and rng.randf_range(0,1)>0.99) or rng.randf_range(0,1)>0.99):
		doturn()

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
		
	if not is_on_floor(): velocity.y+=gravity
	
	var speednow = sprspeed if sprinting else speed
	velocity.x += accel*dir
	velocity.x = lerp(velocity.x,clampf(velocity.x,-speednow,speednow),0.1)
	
	
	if doclimb: 
		velocity=Vector2.UP*60
		spr.frame=2 if animclock>5 else 3

	move_and_slide()

	
func jump():
	jumpstate = 2
	var rng = RandomNumberGenerator.new()
	velocity.y=-rng.randf_range(340,830)
	jumpclock= rng.randi_range(jumpmint,jumpmaxt)
	
func dojump():
	if is_on_floor():
		jumpstate = 2
		velocity.y=-1200
		jumpclock= jumpmaxt

func doturn():
	dir=-sign(dir)

func climb():
	doclimb=true

func fuckingdie(_score=1):
	print(_score
	)
	global.score+=_score
	queue_free()
