extends Area2D

@export var actinduced: String = 'jump'
@export var probability: float = 0.5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	print(body)
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	match actinduced:
		'jump':
			if rng.randf_range(0,1)<=probability:if body.has_method('jump'):
				body.jump()
				print('adasd')
		'turn':
			if rng.randf_range(0,1)<=probability:if body.has_method('doturn'):
				body.doturn()
