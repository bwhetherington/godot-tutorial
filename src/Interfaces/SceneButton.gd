extends Button
class_name SceneButton

export var next_scene: PackedScene

func _pressed():
    get_tree().change_scene_to(next_scene)
