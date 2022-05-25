extends Node2D

func set_camera_limits() -> void:
	var map_limits = $TileMap.get_used_rect()
	var map_cell_size = $TileMap.cell_size
	
	var camera = $Player/Camera2D
	camera.limit_left = (map_limits.position.x + 0.5) * map_cell_size.x
	camera.limit_right = (map_limits.end.x - 0.5) * map_cell_size.x
	camera.limit_top = (map_limits.position.y + 0.5) * map_cell_size.y
	camera.limit_bottom = (map_limits.end.y - 0.5) * map_cell_size.y

func _ready() -> void:
	set_camera_limits()
