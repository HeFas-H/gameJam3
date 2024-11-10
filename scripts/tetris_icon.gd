extends StaticBody2D

#@onready var tetris_lvl = preload("res://nodes/tetris.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if global.commands.has("gravity"):
		queue_free()

func Destroy() -> void:
	get_tree().change_scene_to_file("res://nodes/worlds/tetris.tscn")
