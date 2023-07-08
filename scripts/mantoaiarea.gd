extends Area2D

@export var actinduced: String = 'jump'
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	if rng.randi_range(0,1)==1:match actinduced:
		'jump':
			if body.has_method('dojump'):
				body.dojump()
		'turn':
			if body.has_method('doturn'):
				body.doturn()
