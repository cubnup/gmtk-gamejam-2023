extends CharacterBody2D

@onready var spr = get_node('sprite')
@onready var coll = get_node('coll')

var speed = 300.0
var speedmin = 150.0
var speedmax = 250.0
var hopvel = 150.0
var hopmin = 350.0
var hopmax = 550.0
var jumpvel = 150.0
var jumpmin = 300.0
var jumpmax = 450.0
var jumpstate = 1
var jumpnow = 0.0
var jumpclock = 0
var jumptime = 10

var crouchclock=0

var gravity = 49.1
var normalg = 29.1
var jumpg = 8.1
var fallg = 49.2
var animclock = 0


func _physics_process(delta):
	
	animclock = (animclock+1)%12
	if not is_on_floor(): velocity.y+=gravity
	
	if is_on_floor():
		jumpstate = 1
		if abs(velocity.x)>60 or (abs(velocity.x)>0 and sign(velocity.x)==sign(Input.get_axis("l", "r"))): spr.frame = 3 if (animclock>5) else 4
		else: spr.frame = 0
		if sign(velocity.x)!=0 and sign(velocity.x)==-sign(Input.get_axis("l", "r")):
			spr.frame = 1
		if Input.is_action_pressed("d"):
			spr.frame = 2
			crouchclock=20
			spr.modulate = Color(1, 0, 0, 1) if animclock>5 else Color(1, 1, 1, 1)
		else:
			spr.modulate = Color(1, 1, 1, 1)
	if !Input.is_action_pressed("d") or !is_on_floor():spr.modulate = Color(1, 1, 1, 1)
		
	if crouchclock>0:
		jumpnow =-jumpvel*1.5
		crouchclock-=1
	if Input.is_action_just_pressed("jump") and jumpstate==1:
		jumpstate=2
		jumpnow = -jumpvel
		velocity.y = jumpnow
		jumpclock=jumptime


	match jumpstate:
		0:
			gravity = fallg
			spr.frame = 7
		1:
			gravity = normalg
		2:
			gravity = lerp(jumpg,fallg,jumpclock/jumptime)
			velocity.y= jumpnow
			if Input.is_action_just_released('jump') or jumpclock == 0:
				jumpstate = 0
				throw()
			if jumpclock/jumptime <0.5: spr.frame = 5
			else: spr.frame = 6
	
	if jumpclock>0:jumpclock-=1
		
		
		
	if Input.is_action_pressed("shift"):
		var rng = RandomNumberGenerator.new()
		
		speed = lerp(speed,speedmin,0.05)
		if is_on_floor():
			if rng.randi_range(1,2)==1:throw()
			velocity.y = -max(hopvel*abs(velocity.x/speed),200)
	else:
		speed = lerp(speed,speedmax,0.1)
		if abs(velocity.x)>0: spr.scale.x=-sign(velocity.x)
		
		
	jumpvel = lerp(jumpmin,jumpmax,abs(velocity.x)/speed)
	hopvel = lerp(hopmin,hopmax,0.05)



	var direction = Input.get_axis("l", "r")
	if direction and !Input.is_action_pressed("d"):
		velocity.x = lerp(velocity.x, direction * speed, 0.035)
	else:
		if Input.is_action_pressed("d"): velocity.x = lerp(velocity.x,0.0,0.01)
		else: velocity.x = lerp(velocity.x,0.0,0.05)

	move_and_slide()


func throw():
	print('Thrown!')
