extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	var direction = Input.get_axis("Player_2_move_left" , "Player_2_move_right")
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Player_2_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("Player_2_punch") and is_on_floor():
		$AnimationPlayer.play("Punch")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if Input.is_action_pressed("Player_2_move_left"):
		velocity.x = direction * SPEED
		$AnimationPlayer.play("Walk_Player_2")
	elif Input.is_action_pressed("Player_2_move_right"):
		velocity.x = direction * SPEED
		$AnimationPlayer.play("Walk_Player_2")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimationPlayer.play("Idle_Player_2")
		
	if Input.is_action_pressed("Player_2_punch") and is_on_floor():
		$AnimationPlayer.play("Punch")

	move_and_slide()


func _on_hand_body_entered(body):
	if body is CharacterBody2D:
		if body.name == "Player1":
			print("Player 1 is hit!")
