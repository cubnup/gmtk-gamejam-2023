extends Camera2D

@onready var global = get_node('/root/global')
@onready var scorebar = get_node("score")
@onready var wavebar = get_node("wave")
@onready var arrow = get_node("arrow")
@onready var leaves = get_node("leaves")
@onready var leaves2 = get_node("leaves2")
@onready var sky = get_node("sky")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if global.score==0: scorebar.text = '0'
	else: scorebar.text = str(global.score)
	wavebar.text = str(global.wave)
	
	if global.wave>=10:
		arrow.frame=2
	elif !global.enemanager.timer.is_stopped():
		arrow.frame=3
	else: arrow.frame = global.enemanager.currentspawner
	
	
	position.x=lerp(position.x,global.bro.global_position.x+global.bro.velocity.x*0.5,0.05)
	position.y=lerp(position.y,global.bro.global_position.y+90,0.01)
	sky.position.x=position.x*-0.05
	
