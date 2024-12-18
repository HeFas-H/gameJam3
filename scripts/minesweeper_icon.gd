extends StaticBody2D

#@onready var tetris_lvl = preload("res://nodes/tetris.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if global.commands.has("destroy"):
		queue_free()

func Use() -> void:
	global.cur_level = 1
	get_tree().change_scene_to_file("res://nodes/worlds/minesweeper.tscn")
