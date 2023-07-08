extends Area2D

@export var type :int = 0
@export var amount :int = 7
@onready var spr = get_node("sprite")
@onready var particles = get_node("particles")
var dying = false
var clock=0.0


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	clock+=0.05
	particles.texture = spr.texture
	global_position.y+=sin(clock)
	scale.y-=0.001
	scale.x-=0.001
	if dying == true:
		scale.x-=0.05
		scale.y-=0.05
		particles.emitting=true
		if scale.x<=0 or clock == 30:
			queue_free()
	else:
		particles.emitting=false

func _on_body_entered(body):
	if body.has_method('powerup'):
		body.powerup(type,amount)
		global.bro.ltrail.tpos = global_position
		dying = true
