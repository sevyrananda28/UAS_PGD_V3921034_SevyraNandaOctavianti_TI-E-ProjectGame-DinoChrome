extends KinematicBody2D

var gravity = 50
var velocity =Vector2.ZERO
var jump_force = 600
var audiostream = ResourceLoader.load("res://audio/jump.wav")

func _physics_process(delta):
	velocity.y += gravity
	move_and_slide(velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		$DinoSound.stream = audiostream
		$DinoSound.play()
		
		velocity.y = -jump_force
		
