extends CharacterBody3D

const SPEED: float = 8.0
const GRAVITY:= -3.0
const JUMP_STRENGTH:= 40.0
var vel := Vector3.ZERO

@onready var cam = $Camera3D

func _ready():
	cam.current = is_multiplayer_authority()

func _physics_process(delta: float) -> void:
	if is_multiplayer_authority():
		if not is_on_floor():
			vel.y+=GRAVITY
		else:
			vel.y=0
	
		if Input.is_action_just_pressed("jump"):
			vel.y = JUMP_STRENGTH
	
		if Input.is_action_just_pressed("quit"):
			$"../".exit_game(name.to_int())
			get_tree().quit()
	
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

func _enter_tree():
	set_multiplayer_authority(name.to_int())
