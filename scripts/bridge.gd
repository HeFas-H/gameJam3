extends StaticBody2D

@onready var obstacles = $Obstacles
@onready var obstacle = preload("res://nodes/file_obstacle.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Rar.global_rotation = 0
	$CollisionShape2D.global_rotation = 0
	$Obstacles/IconLock.global_rotation = 0
	$Obstacles/IconLock.global_position = global_position + Vector2(15,15)
	
var is_destroyed = false
	
func Destroy() -> void:
	is_destroyed = true
	for el in obstacles.get_children():
		el.queue_free()
	for i in get_meta("Length"):
		var obst_file = obstacle.instantiate()
		obst_file.pos = Vector2((i+1)*48, 0) - global_position
		obst_file.set_meta("can_disappear", get_meta("can_disappear"))
		obstacles.add_child(obst_file)
	if !get_meta("can_reload"):
		get_meta("coms").erase("destroy")

func Use() -> void:
	if !is_destroyed: 
		return
	for el in obstacles.get_children():
		el.queue_free()
	for i in get_meta("Length"):
		var obst_file = obstacle.instantiate()
		obst_file.pos = Vector2((i+1)*48, 0) - global_position
		obst_file.set_meta("can_disappear", get_meta("can_disappear"))
		obst_file.set_meta("can_reload", false)
		obstacles.add_child(obst_file)
	if !get_meta("can_reload"):
		get_meta("coms").erase("use")
