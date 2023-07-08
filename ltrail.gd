extends Node2D

@onready var global = get_node('/root/global')
@onready var traillarva = preload('res://scenes/traillarva.tscn')
var larvae = 0
var larvarr = []


func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	
	larvae = global.bro.larvae
	if len(larvarr)<larvae:
		for i in range(larvae-len(larvarr)):
			var t = traillarva.instantiate()
			larvarr.append(t)
			get_tree().get_root().add_child(t)
	if len(larvarr)>larvae:
		larvarr[0].queue_free()
		larvarr.pop_front()
	for l in larvarr:
		l.index=larvarr.find(l)

func empty():
	for l in larvarr:
		l.queue_free()
	
