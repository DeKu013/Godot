extends Node
var enemy_scene = preload("res://entities/enemies/enemy.tscn")

func _ready():
	get_parent().get_node("Boundary").connect( "area_enetered" , _the_end )
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0
	timer.connect("timeout",_create_enemy)
	timer.start()

func _create_enemy():
	var enemy = enemy_scene.instantiate()
	enemy.position.x = randi_range( 20 , 380 )
	get_parent().get_node("Enemies").add_child(enemy)

func _the_end(body:Node):
	if body is Enemy:
		get_tree().set_paused(true)
