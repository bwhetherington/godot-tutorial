extends Actor
class_name Player

var has_touched_floor = false

var state_machine: StateMachine

func perform_wall_jump() -> void:
    var wall: Vector2 = get_wall_direction()
    apply_force(wall * jump_strength)
    input_velocity.y = 1
    has_touched_floor = false
    
func perform_floor_jump() -> void:
    input_velocity.y = 1
    has_touched_floor = false

func get_max_y_speed() -> float:
    var parent: float = .get_max_y_speed()
    if is_on_wall():
        return parent / 20
    return parent

func _physics_process(delta: float) -> void:
    if is_on_floor():
        has_touched_floor = true
    
    # Handle horizontal input
    input_velocity.x = 0
    input_velocity.y = 0

    if Input.is_action_pressed("move_left"):
        input_velocity.x -= 1
    if Input.is_action_pressed("move_right"):
        input_velocity.x += 1
        
    # 
    
    # Handle vertical input
    if Input.is_action_just_pressed("jump"):
        if is_on_wall() and not is_on_floor():
            perform_wall_jump()
        elif has_touched_floor:
            perform_floor_jump()
    
    #._physics_process(delta)
