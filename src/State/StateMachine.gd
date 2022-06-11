class_name StateMachine
extends Node

signal transitioned(state_name)

export var initial_state: NodePath = NodePath()

onready var state: State = get_node(initial_state)

func _init_state(state: State) -> void:
	state.connect("transitioned", self, "_on_state_transitioned")
	
func _on_state_transitioned(target_state_name: String, msg: Dictionary = {}) -> void:
	transition_to(target_state_name, msg)

func _ready() -> void:
	yield(owner, "ready")
	for child in get_children():
		_init_state(child)
	if state:
		state.enter()

func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)
	
func _process(delta: float) -> void:
	state.update(delta)
	
func _physics_process(delta: float) -> void:
	state.physics_update(delta)
	
func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	if not has_node(target_state_name):
		return
		
	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)
	emit_signal("transitioned", state.name)
