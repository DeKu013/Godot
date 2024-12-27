extends CharacterBody3D

const SPEED: float = 10.0
const GRAVITY:= -5.0
const JUMP_STRENGTH:= 40.0
var vel := Vector3.ZERO

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		vel.y+=GRAVITY
	else:
		vel.y=0
	
	if Input.is_action_just_pressed("jump"):
		vel.y = JUMP_STRENGTH
	
	var playerInput = getPlayerInputs() * SPEED
	vel.x = playerInput.x
	vel.z = playerInput.z
	
	velocity = vel
	move_and_slide()

func getPlayerInputs() -> Vector3:
	var r:= Vector3.ZERO
	r.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	r.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	return r
