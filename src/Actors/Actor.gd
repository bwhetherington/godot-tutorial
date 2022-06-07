extends KinematicBody2D
class_name Actor

# Exported properties
export var speed: Vector2 = Vector2(75, 650)
export var gravity: float = 250
export var jump_strength: float = 120

# Acceleration-related properties
export var air_acceleration: float = 100
export var ground_acceleration: float = 1000

export var air_deceleration: float = 50
export var ground_deceleration: float = 1000

export var enable_interpolation: bool = true

var _velocity: Vector2 = Vector2.ZERO
var input_velocity: Vector2 = Vector2.ZERO

var last_physics_time: int = 0
var last_physics_pos: Vector2 = Vector2.ZERO

func cap_speed() -> void:
    if abs(_velocity.x) > speed.x:
        _velocity.x = speed.x * sign(_velocity.x)
        
func get_max_y_speed() -> float:
    return speed.y
        
func process_input_velocity(delta: float) -> void:
    # Apply deceleration if not moving
    if input_velocity.length_squared() == 0:
        var dec = ground_deceleration if is_on_floor() else air_deceleration
        var dir = sign(_velocity.x)
    
        var min_speed = min(_velocity.x, 0)
        var max_speed = max(_velocity.x, 0)
        _velocity.x = clamp(_velocity.x - (dir * dec * delta), min_speed, max_speed)
        
    # Apply jump
    if input_velocity.y > 0:
        _velocity.y = -jump_strength

    ## Apply acceleration
    var acc = ground_acceleration if is_on_floor() else air_acceleration
    _velocity.x += input_velocity.x * delta * acc
        
    cap_speed()
    
func process_velocity(delta: float) -> void:
    process_input_velocity(delta)
    _velocity.y += gravity * delta
    var max_y_speed: float = get_max_y_speed()
    if _velocity.y > max_y_speed:
        _velocity.y = max_y_speed
    _velocity = move_and_slide_with_snap(_velocity, Vector2.DOWN, Vector2.UP)

func _physics_process(delta: float) -> void:
    process_velocity(delta)
    last_physics_pos = global_transform.origin
    
func apply_force(force: Vector2) -> void:
    _velocity += force
    
func get_wall_direction() -> Vector2:
    var count: int = get_slide_count()
    if count != 0:
        return get_slide_collision(0).normal
    return Vector2.ZERO
    
onready var sprite: Sprite = $Sprite

func interpolate_position(delta: float) -> void:
    pass

func _process(delta: float) -> void:
    if enable_interpolation:
        var fps: = Engine.get_frames_per_second()
        if fps > Engine.iterations_per_second:
            var lerp_interval: = _velocity / fps
            var lerp_position = global_transform.origin + lerp_interval
            sprite.set_as_toplevel(true)
            sprite.global_transform.origin = sprite.global_transform.origin.linear_interpolate(lerp_position, 40 * delta)
        else:
            sprite.set_as_toplevel(true)
            sprite.global_transform.origin = global_transform.origin
