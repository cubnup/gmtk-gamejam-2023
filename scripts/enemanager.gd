extends Node2D

@onready var spawners = [get_node('spawner'),get_node('spawner2')]
@onready var timer = get_node('timer')
@onready var manto = preload('res://scenes/manto.tscn')
@onready var global = get_node('/root/global')

var mantomana = 0
var enemies = []
var currentspawner = 0

func _ready():
	timer.start()
	global.enemanager=self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if mantomana>0:
		mantospawn()
		mantomana-=1
	if mantomana==0 and len(enemies)==0 and timer.is_stopped():
		timer.start()
	
func mantospawn():
	if global.wave>10:
		currentspawner=randi_range(0,1)
	var m = manto.instantiate()
	m.global_position = spawners[currentspawner].global_position
	enemies.append(m)
	add_child(m)


func _on_timer_timeout():
	print('fuck you too')
	global.waveup()
	mantomana = global.wave
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	currentspawner=randi_range(0,1)
