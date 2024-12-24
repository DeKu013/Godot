extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	var direction = Input.get_axis("Player_1_move_left", "Player_1_move_right")
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Player_1_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimationPlayer.play("Jump_Player_1")
		if Input.is_action_just_pressed("Player_1_jump_kick"):
			$AnimationPlayer.play("Jump_kick")
		elif Input.is_action_just_pressed("Player_1_dive_kick"):
			$AnimationPlayer.play("Dive_kick")
		
	if Input.is_action_just_pressed("Player_1_punch_jab") and is_on_floor():
		$AnimationPlayer.play("Jab_and_punch")
	
	if Input.is_action_just_pressed("Player_1_kick") and is_on_floor():
		$AnimationPlayer.play("Kick")
	
	if Input.is_action_pressed("Player_1_move_left"):
		velocity.x = direction * SPEED
		$AnimationPlayer.play("Walk_Player_1")
	elif Input.is_action_pressed("Player_1_move_right"):
		velocity.x = direction * SPEED
		$AnimationPlayer.play("Walk_Player_1")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimationPlayer.play("Idle_Player_1")
	

	move_and_slide()
