extends Node2D
class_name LevelTemplate

const SPRITE_SIZE: int = 32

func set_camera_limits() -> void:
    var map_limits = $Walls.get_used_rect()
    print_debug(map_limits)
    var map_cell_size = $Walls.cell_size
    var map_pos = $Walls.global_transform.get_origin()
    
    var camera = $Player/Camera2D
    var x_size = map_cell_size.x
    var y_size = map_cell_size.y
    camera.limit_left = (map_limits.position.x + 0.5) * x_size + map_pos.x
    camera.limit_right = (map_limits.end.x - 0.5) * x_size + map_pos.x
    camera.limit_top = (map_limits.position.y + 0.5) * y_size + map_pos.y
    camera.limit_bottom = (map_limits.end.y - 0.5) * y_size + map_pos.y
    
    var background = $ParallaxBackground/ParallaxLayer/BackgroundSprite as Sprite
    
    if background == null:
        return
        
    
    var scale = background.transform.get_scale()
    var position = background.transform.get_origin()
    
    
    var width = (map_limits.end.x - map_limits.position.x) * x_size
    var height = (map_limits.end.y - map_limits.position.y) * y_size

    scale.x = width / SPRITE_SIZE
    scale.y = height / SPRITE_SIZE
    print_debug(scale)
    
    position.x = map_pos.x
    position.y = map_pos.y

func _ready() -> void:
    set_camera_limits()
