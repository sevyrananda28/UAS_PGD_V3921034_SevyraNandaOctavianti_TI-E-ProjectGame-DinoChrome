extends Node2D

export (Array, PackedScene) var scene_obstacle

onready var camera = $Camera2D
onready var obs_position = $obs_pos.position
onready var obs_y_position = [
	$obs_pos.position.y,
	$obs_y_pos_1.position.y,
	$obs_y_pos_2.position.y
]
onready var obs_container = $obs_container

onready var label_score = $Camera2D/score
onready var label_hi_score = $Camera2D/hi_score
onready var start_position =$Camera2D.position.x

onready var label_end = $Camera2D/end

var speed = 200
var score = 0

var level_speed = 1
var level_up = 0.1
var max_level_speed = 2
var next_level 
var level_length = 100


func camera_movement(delta):
	camera.position.x += speed * level_speed * delta


func obs_generator(amount):
	for i in amount:
		var type = randi() % 2
		var new_obs

		if type == 0:
			new_obs = scene_obstacle[type].instance() as Area2D
			new_obs.position = obs_position
		else:
			new_obs = scene_obstacle[type].instance() as Area2D
			new_obs.position.x = obs_position.x
			new_obs.position.y = obs_y_position[randi() % 3]
			
		if new_obs:
			new_obs.connect("player_hit_obstacle", self, "player_hit_obstacle")
			obs_container.call_deferred("add_child", new_obs)
			obs_position.x += rand_range(200, 350)
			
			
func player_hit_obstacle():
	get_tree().paused = true
	label_end.visible = true
	label_end.last_score = score

			
func score_update ():
	score = int((camera.position.x - start_position)/10)
	label_score.text = str(score)			
	
	
func level_update():
	if score < next_level:
		return
		
	if score > next_level:
		if level_speed < max_level_speed:
			level_speed += level_up
			next_level += level_length
			
			
func _ready():
	randomize()
	next_level = level_length
	label_hi_score.text = "HIGH SCORE " + str(Global.hi_score)
	obs_generator(50)


func _physics_process(delta):
	camera_movement(delta)
	score_update()
	level_update()
	print(score,", ", level_speed)

func _on_obs_eraser_area_entered(area):
	area.queue_free()
	obs_generator(1)
