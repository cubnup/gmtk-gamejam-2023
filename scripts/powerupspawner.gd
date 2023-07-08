extends Node2D

var clock = 0

var probs = [0.4,0.33,0.24,0.03]
@onready var pu0 = preload("res://scenes/larvapickup.tscn")
@onready var pu1 = preload("res://scenes/rangpickup.tscn")
@onready var pu2 = preload("res://scenes/flowerpickup.tscn")
@onready var pu3 = preload("res://scenes/poundpickup.tscn")

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	clock=(clock+1)%75
	if clock==0:
		var spawn=0
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var dir = sign(global.bro.global_position.x-global.flower.global_position.x)
		var rval = rng.randf_range(0,1)
		var rposx = randf_range(250,1250)
		var rposy = randf_range(50,-100)
		var sum =0
		for i in len(probs):
			sum+=probs[i]
			if sum>rval:
				spawn=i
				break
			spawn = len(probs)-1
		var pu = [pu0,pu1,pu2,pu3][spawn].instantiate()
		pu.type = spawn
		pu.global_position = Vector2(global.flower.global_position.x +rposx*dir,rposy)
		get_tree().get_root().add_child(pu)
