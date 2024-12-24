extends Camera2D

@export var tilemap : TileMap
# Called when the node enters the scene tree for the first time.

#Makes the camera limit shift to next scene when leaving the current scene
func _ready():
	var mapRect = tilemap.get_used_rect()
	var tileSize = tilemap.cell_quadrant_size
	var worldSizePx = mapRect.size * tileSize
	limit_right = worldSizePx.x
	limit_bottom = worldSizePx.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
