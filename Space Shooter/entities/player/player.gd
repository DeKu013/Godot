extends Node2D

# variables to determine movement specifics
var direction:int = 0
var speed:int = 300
var player_width_half:int = 16
var bullet_scene = preload("res://entities/bullets/bullet.tscn")
var shoot_time:= 1.0
var shoot_counter = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Function to allow movement for ship
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	shoot_counter+=delta
	if Input.is_action_pressed("Shoot") and shoot_counter>shoot_time:
		shoot_counter = 0
		var bullet_instance = bullet_scene.instantiate()
		bullet_instance.position.x = position.x + 190
		bullet_instance.position.y = position.y + 440
		get_parent().get_node("Bullets").add_child(bullet_instance)
	if Input.is_action_pressed("move_left"):
		direction = -1
	elif Input.is_action_pressed("move_right"):
		direction = 1
	else:
		direction = 0
		
	position.x = clamp( position.x + direction*speed*delta , 2*player_width_half - 200 , 200 - player_width_half )
