extends Camera2D

@onready var global = get_node('/root/global')

func _ready():
	global.lbar = get_node("lbar")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.x=lerp(position.x,global.bro.global_position.x+global.bro.velocity.x*0.5,0.1)
