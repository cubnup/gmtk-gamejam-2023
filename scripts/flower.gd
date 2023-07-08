extends StaticBody2D

@onready var global = get_node('/root/global')
@onready var larvaline = get_node('larvaline')
@onready var spr = get_node('sprite')

var health = 5

var chargedist = 100
func _ready():
	global.flower=self
	larvaline.points[0]=global_position
	larvaline.points[1]=global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	spr.frame = 5-health
	if -(global.bro.global_position.x-global_position.x)>chargedist:
		larvaline.points[0]=larvaline.points[0].lerp(Vector2.ZERO,0.1)
		larvaline.points[1]=larvaline.points[1].lerp((global.bro.global_position-larvaline.global_position)*0.6,0.2)
		global.bro.recharge()
	else:
		larvaline.points[0]=larvaline.points[0].lerp(Vector2.ZERO,0.1)
		larvaline.points[1]=larvaline.points[1].lerp(Vector2.ZERO,0.1)




func _on_area_2_body_entered(body):
	if body.has_method('climb'):
		body.climb()


func _on_area_body_entered(body):
	if body.has_method('climb'):
		if body.doclimb:
			health-=1
			body.queue_free()