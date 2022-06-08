extends Node2D
class_name LevelTemplate

func set_camera_limits() -> void:
	var map_limits = $TileMap.get_used_rect()
	var map_cell_size = $TileMap.cell_size
	var map_pos = $TileMap.global_transform.get_origin()
	print_debug(map_limits.position, map_limits.end)
	
	var camera = $Player/Camera2D
	var x_size = map_cell_size.x
	var y_size = map_cell_size.y
	camera.limit_left = (map_limits.position.x + 0.5) * x_size + map_pos.x
	camera.limit_right = (map_limits.end.x - 0.5) * x_size + map_pos.x
	camera.limit_top = (map_limits.position.y + 0.5) * y_size + map_pos.y
	camera.limit_bottom = (map_limits.end.y - 0.5) * y_size + map_pos.y
	

func _ready() -> void:
	set_camera_limits()
