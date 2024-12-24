extends Sprite3D

var coins = 5
var player_name = 'guest'
var hearts = 3.5
const SPEED = 2
var x = coins + SPEED

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		rotate_x(SPEED)
	elif Input.is_action_just_pressed("ui_down"):
		rotate_x(-SPEED)
	elif Input.is_action_just_pressed("ui_left"):
		rotate_y(-SPEED)
	elif Input.is_action_just_pressed("ui_right"):
		rotate_y(SPEED)
