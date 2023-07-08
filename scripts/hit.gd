extends GPUParticles2D

@onready var spr = get_node("manto")
var fallspd = -5
var speedx = 0
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	fallspd+=0.1
	spr.scale.y=-2
	spr.modulate = Color(0.7, 0.7, 0.7, 1)
	global_position.x+=speedx
	global_position.y+=fallspd
	if global_position.y>10000:
		queue_free()
