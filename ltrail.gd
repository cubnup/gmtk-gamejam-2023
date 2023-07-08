extends Node2D

@onready var global = get_node('/root/global')
@onready var traillarva = preload('res://scenes/traillarva.tscn')
var larvae = 0
var larvarr = []
var tpos = Vector2.ZERO

func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	
	larvae = global.bro.larvae
	if len(larvarr)<len(larvae):
		for i in larvae.slice(len(larvarr)):
			newlarva(i)
	if len(larvarr)>len(larvae):
		larvarr[0].queue_free()
		larvarr.pop_front()
	for l in larvarr:
		l.index=larvarr.find(l)
		
	for l in range(len(larvae)):
		larvarr[l].get_node('sprite').frame = larvae[l]

func empty():
	for l in larvarr:
		l.queue_free()
	

func newlarva(_type=0):
	var t = traillarva.instantiate()
	larvarr.push_front(t)
	t.global_position=tpos
	get_tree().get_root().add_child(t)
