extends KinematicBody2D
class_name Actor

# Exported properties
export var speed: Vector2 = Vector2(75, 500)
export var gravity: float = 250
export var jump_strength: float = 120

# Acceleration-related properties
export var air_acceleration: float = 100
export var ground_acceleration: float = 250

export var air_deceleration: float = 50
export var ground_deceleration: float = 450

var _velocity: Vector2 = Vector2.ZERO
var input_velocity: Vector2 = Vector2.ZERO

func cap_speed() -> void:
	if abs(_velocity.x) > speed.x:
		_velocity.x = speed.x * sign(_velocity.x)
		
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
	_velocity = move_and_slide(_velocity, Vector2.UP)

func _physics_process(delta: float) -> void:
	process_velocity(delta)
	
func apply_force(force: Vector2) -> void:
	_velocity += force
	
func get_wall_direction() -> Vector2:
	var count: int = get_slide_count()
	if count != 0:
		return get_slide_collision(0).normal
	return Vector2.ZERO
