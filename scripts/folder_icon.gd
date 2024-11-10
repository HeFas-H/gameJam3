extends StaticBody2D

@onready var explorer = preload("res://nodes/folder.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func Destroy() -> void:
	var folder = explorer.instantiate()
	folder.scale = Vector2(0.1, 0.1)
	folder.global_position = global_position
	folder.set_meta("size", get_meta("size"))
	get_tree().root.add_child(folder)
	queue_free()
