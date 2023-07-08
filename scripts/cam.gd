extends Camera2D

@onready var global = get_node('/root/global')
@onready var scorebar = get_node("score")
@onready var leaves = get_node("leaves")
@onready var leaves2 = get_node("leaves2")
@onready var sky = get_node("sky")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	scorebar.text = str(global.score)
	position.x=lerp(position.x,global.bro.global_position.x+global.bro.velocity.x*0.5,0.05)
	position.y=lerp(position.y,global.bro.global_position.y+90,0.01)
	sky.position.x=position.x*-0.05
	
