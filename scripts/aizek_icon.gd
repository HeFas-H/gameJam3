extends StaticBody2D

func Destroy() -> void:
	global.cur_level = 5
	get_tree().change_scene_to_file("res://nodes/worlds/aizek.tscn")
