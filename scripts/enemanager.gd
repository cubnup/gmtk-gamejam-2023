extends Node2D

@onready var spawners = [get_node('spawner'),get_node('spawner2')]
# Called when the node enters the scene tree for the first time.

var enemymana = 0

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rng = RandomNumberGenerator.new()
	
	enemymana+=1
	
