class_name State
extends Node

signal transitioned(target_state_name, msg)

func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	emit_signal("transitioned", target_state_name, msg)

func handle_input(_event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(_delta: float) -> void:
	pass
	
func enter(_msg := {}) -> void:
	pass
	
func exit() -> void:
	pass
