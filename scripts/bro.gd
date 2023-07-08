extends CharacterBody2D

@onready var spr = get_node('sprite')
@onready var coll = get_node('coll')
@onready var ltrail = get_node('ltrail')
@onready var larva = preload("res://scenes/larva.tscn")
@onready var larvarang = preload("res://scenes/larvarang.tscn")
@onready var global = get_node('/root/global')


var speed = 170.0
var speedmin = 150.0
var speedmax = 250.0
var hopvel = 150.0
var hopmin = 350.0
var hopmax = 550.0
var jumpvel = 150.0
var jumpmin = 400.0
var jumpmax = 650.0
var jumpstate = 1
var jumpnow = 0.0
var jumpclock = 0
var jumptime = 17

var crouchclock=0

var gravity = 49.1
var normalg = 29.1
var jumpg = 0.1
var fallg = 69.2
var animclock = 0
var dir = -1
var larvaepercharge = 5
var larvae = 10
var larvaclock =0 

var throwtype = 0

var coyote = 30
var charging = 0
var chargeclock = 0
var chargedist = 0


func _ready():
	global.bro=self


func _physics_process(delta):
	if charging>0:charging-=1
	if Input.is_action_just_pressed("reload"):
		global.score=0
		ltrail.empty()
		get_tree().reload_current_scene()
	animclock = (animclock+1)%12
	if not is_on_floor(): velocity.y+=gravity
	var direction = Input.get_axis("l", "r")
	
	if !Input.is_action_pressed("shift") and abs(velocity.x)>0:
		dir = sign(velocity.x) 
	
	if is_on_floor():
		coyote = 30
		jumpstate = 1
		if abs(velocity.x)>60 or (abs(velocity.x)>0 and sign(velocity.x)==sign(Input.get_axis("l", "r"))):
			spr.frame = 3 if (animclock>5) else 4
		else: spr.frame = 0
		if abs(velocity.x)>60 and sign(velocity.x)==-sign(Input.get_axis("l", "r")):
			spr.frame = 1
	else:
		if coyote>0:coyote-=1
		else:jumpstate=0
	
	if Input.is_action_pressed('d') and is_on_floor():
		set_collision_mask_value(5,false)
		set_collision_layer_value(5,false)
	else:
		set_collision_mask_value(5,true)
		set_collision_layer_value(5,true)
	if Input.is_action_pressed("d"):
		if is_on_floor():
			spr.frame = 2
			if crouchclock<=30:crouchclock+=3
		else: 
			velocity.x = lerp(velocity.x, direction * speed, 0.035)
	else:
		spr.modulate = Color(1, 1, 1, 1)
			
	if !Input.is_action_pressed("d") or !is_on_floor():
		spr.modulate = Color(1, 1, 1, 1)
		if charging==0:
			spr.modulate = Color(0.7, 0.7, 0.7, 1)
		
	if crouchclock>0:
		if crouchclock>15:jumpnow =-jumpvel*2
		crouchclock-=1
		if crouchclock>15:
			if animclock>5: spr.modulate = Color(1, 0, 0, 1) 
	if Input.is_action_just_pressed("jump") and jumpstate==1:
		jumpstate=2
		jumpnow = -jumpvel
		velocity.y = jumpnow
		jumpclock=jumptime

	match jumpstate:
		0:
			gravity = fallg
			spr.frame = 7
#			if Input.is_action_just_pressed("shift"):throw()
		1:
			gravity = normalg
		2:
			gravity = lerp(jumpg,fallg,jumpclock/jumptime)
			velocity.y= jumpnow
#			if Input.is_action_just_pressed("shift"):throw()
			if Input.is_action_just_released('jump') or jumpclock == 0:
				throw(1.7)
				jumpstate = 0
				
			if jumpclock/jumptime <0.5: spr.frame = 5
			else: spr.frame = 6
	
	if jumpclock>0:jumpclock-=1
		
		
		
	if Input.is_action_pressed("shift"):
		if crouchclock==0:
#			var rng = RandomNumberGenerator.new()
			if is_on_floor():
				velocity.y = -max(hopvel*abs(velocity.x/speed),200)
				speed = lerp(speed,speedmin,0.05)
				if velocity.y>0: spr.frame=6
#				if rng.randi_range(1,4)<=2:
				throw()
				spr.frame =7
			else:
				spr.frame=6
	else:
		speed = lerp(speed,speedmax,0.1)
		
		
		
		
	jumpvel = lerp(jumpmin,jumpmax,abs(velocity.x)/speed)
	hopvel = lerp(hopmin,hopmax,0.05)



	if direction and !Input.is_action_pressed("d"):
		velocity.x = lerp(velocity.x, direction * speed, 0.035)
	else:
		if Input.is_action_pressed("d"): velocity.x = lerp(velocity.x,0.0,0.01)
		else: velocity.x = lerp(velocity.x,0.0,0.05)


	spr.scale.x=-2*dir


	move_and_slide()


func throw(_mult=1):
	if larvae>0:
		match throwtype:
			0:
				var l = larva.instantiate()
				l.dir=int(dir)
				l.mult = _mult
				larvae-=1
				l.speedx+=abs(velocity.x)
				l.global_position=global_position+Vector2.UP*20
				get_tree().get_root().add_child(l)
			1:
				var l = larvarang.instantiate()
				l.dir=int(dir)
				l.mult = _mult
				larvae-=1
				l.global_position=global_position+Vector2.UP*20
				get_tree().get_root().add_child(l)
		if larvae==0 and throwtype!=0:
			powerup(0,2)


func recharge(_dist=0):
	charging = 10
	if throwtype == 0:
		larvaclock+=1
		if larvaclock==39-round(_dist/900):
			larvaclock=0
			if larvae<larvaepercharge:larvae+=1

func powerup(_which=0,_howmany=5):
	throwtype=_which
	larvae=_howmany



func _on_mantojump_body_entered(body):
	pass # Replace with function body.
