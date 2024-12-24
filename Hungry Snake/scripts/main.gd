extends Node

@export var snake_scene : PackedScene
var score : int
var game_started : bool = false

var cells : int = 20
var cell_size : int = 50

var food_pos : Vector2
var regen_food : bool = true
# Called when the node enters the scene tree for the first time.
var old_data : Array
var snake_data : Array
var snake : Array

var start_pos = Vector2( 9 , 9 )
var up = Vector2( 0 , -1 )
var down = Vector2( 0 , 1 )
var left = Vector2( -1 , 0 )
var right = Vector2( 1 , 0 )
var move_dir : Vector2
var can_move : bool

func _ready():
	newgame()
	
func newgame():
	get_tree().paused = false
	get_tree().call_group( "segments" , "queue_free" )
	$GameOverMenu.hide()
	score = 0
	$TopLayer.get_node("ScoreLabel").text = "SCORE : " + str(score)
	move_dir = up
	can_move = true
	generateSnake()
	move_food()
	
func generateSnake():
	old_data.clear()
	snake_data.clear()
	snake.clear()
	for i in range( 3 ):
		add_segment( start_pos + Vector2( 0 , 1 ) )

func add_segment( pos ):
	snake_data.append( pos )
	var SnakeSegment = snake_scene.instantiate()
	SnakeSegment.position = ( pos * cell_size ) + Vector2( 0 , cell_size )
	add_child(SnakeSegment)
	snake.append(SnakeSegment)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_snake()

func move_food():
	while regen_food:
		regen_food = false
		food_pos = Vector2( randi_range( 0 , cells-1 ) , randi_range( 0 , cells-1 ) )
		for i in snake_data:
			if food_pos == i:
				regen_food = true
	$Food.position = ( food_pos * cell_size ) + Vector2( 0 , cell_size )
	regen_food = true

func move_snake():
	if can_move:
		if Input.is_action_just_pressed("move_down") and move_dir != up:
			move_dir = down
			can_move = false
			if not game_started:
				start_game()
		if Input.is_action_just_pressed("move_up") and move_dir != down:
			move_dir = up
			can_move = false
			if not game_started:
				start_game()
		if Input.is_action_just_pressed("move_left") and move_dir != right:
			move_dir = left
			can_move = false
			if not game_started:
				start_game()
		if Input.is_action_just_pressed("move_right") and move_dir != left:
			move_dir = right
			can_move = false
			if not game_started:
				start_game()

func start_game():
	game_started = true
	$MoveTimer.start()
	
func _on_move_timer_timeout():
	can_move = true
	old_data = [] + snake_data
	snake_data[0] += move_dir
	for i in range(len(snake_data)):
		if i > 0:
			snake_data[i] = old_data[i-1]
		snake[i].position = ( snake_data[i] * cell_size ) + Vector2( 0 , cell_size )
	check_out_of_bounds()
	check_self_eaten()
	check_food_eaten()

func check_out_of_bounds():
	if snake_data[0].x < 0 or snake_data[0].x > cells - 1 or snake_data[0].y < 0 or snake_data[0].y > cells -1:
		end_game()

func check_self_eaten():
	for i in range( 1 , len(snake_data) ):
		if snake_data[0] == snake_data[i]:
			end_game()

func check_food_eaten():
	if snake_data[0] == food_pos:
		score += 1
		$TopLayer.get_node("ScoreLabel").text = "Score : " + str(score)
		add_segment(old_data[-1])
		move_food()

func end_game():
	$GameOverMenu.show()
	$MoveTimer.stop()
	game_started = false
	get_tree().paused = true

func _on_game_over_menu_restart():
	newgame()
