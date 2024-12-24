class_name Enemy
extends Area2D

var speed:int = 100

func _ready():
	var x_cor:int = randi_range( 20 , 380 )
	var position = Vector2( x_cor , 50 )

func _process(delta):
	position.y = position.y+speed*delta

func _on_area_entered(area:Area2D):
	if area.name == "BulletArea":
		area.get_parent().queue_free()
		queue_free()
