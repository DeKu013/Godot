extends CharacterBody2D

@export var speed : int = 50
@onready var animations = $AnimationPlayer

func handleInput():
	var moveDirection = Input.get_vector("walk_left","walk_right","walk_up","walk_down")
	velocity = moveDirection*speed

func updateAnimations():
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction = "down"
		if velocity.x < 0:
			direction = "left"
		elif velocity.x > 0:
			direction = "right"
		elif velocity.y < 0:
			direction = "up"
		animations.play("walk_" + direction)

func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateAnimations()
