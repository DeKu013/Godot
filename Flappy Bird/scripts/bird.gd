extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var flying : bool = false
var falling : bool = false
const Start_pos = Vector2( 100 , 400 )
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	reset()

func reset():
	falling = false
	flying = false
	position = Start_pos
	set_rotation(0)

func _physics_process(delta):
	if flying or falling:
		velocity.y += gravity * delta
		#if velocity.y > 400:
		#	velocity.y = 400
		if flying:
			set_rotation(deg_to_rad( velocity.y * 0.05 ))
			$AnimatedSprite2D.play()
		elif falling:
			set_rotation( PI/2 )
			$AnimatedSprite2D.stop()
		move_and_slide()
	else:
		$AnimatedSprite2D.stop()

func flap():
	velocity.y = JUMP_VELOCITY
	#if Input.is_action_just_pressed("Flap"):
	#	velocity.y = JUMP_VELOCITY
	
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
	#	velocity.x = direction * SPEED
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
