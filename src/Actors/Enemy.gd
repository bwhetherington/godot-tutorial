extends Actor

func _ready() -> void:
	input_velocity.x = 1

func _physics_process(delta: float) -> void:
	if is_on_wall():
		input_velocity.x *= -1
