extends StaticBody2D

@onready var explorer = preload("res://nodes/folder.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !get_meta("is_locked"):
		$IconLock.queue_free()

func Use() -> void:
	if !get_meta("is_locked"):
		var folder = explorer.instantiate()
		folder.scale = Vector2(0.1, 0.1)
		folder.set_meta("size", get_meta("size"))
		add_child(folder)
		$IconFolder.queue_free()
		$CollisionShape2D.queue_free()
		folder.global_position = global_position

func Destroy() -> void:
	if !get_meta("is_locked"):
		Use()
		return
	var folder = explorer.instantiate()
	folder.scale = Vector2(0.1, 0.1)
	folder.set_meta("size", get_meta("size"))
	add_child(folder)
	$IconFolder.queue_free()
	$CollisionShape2D.queue_free()
	$IconLock.queue_free()
	folder.global_position = global_position
