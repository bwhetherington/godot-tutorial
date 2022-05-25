tool
extends Area2D
class_name ScenePortal

export var next_scene: PackedScene

func _get_configuration_warning() -> String:
	if next_scene:
		return ""
	return "No next_scene specified"

func _ready() -> void:
	$AnimationPlayer.play("stand")
