extends Node

var commands = ["help", "clear", "use"] #gravity destroy %hack
var gravity = Vector2(0, 980)

var cur_level = 0
const PATH = "user://file1.save"

func Save():
	var file = FileAccess.open(PATH, FileAccess.WRITE)
	file.store_64(cur_level)
	file.store_csv_line(self.commands)
	file.close()

var levels = [
	"res://nodes/worlds/world.tscn",
	"res://nodes/worlds/minesweeper.tscn",
	"res://nodes/worlds/world1.tscn",
	"res://nodes/worlds/tetris.tscn",
	"res://nodes/worlds/world2.tscn",
	"res://nodes/worlds/aizek.tscn",
	]

func Load():
	var file = FileAccess.open(PATH, FileAccess.READ)
	cur_level = file.get_64()
	commands = Array(file.get_csv_line())
	#if (cur_level>global.levels.size()):
		#get_tree().change_scene_to_file(levels[levels.size()-1])
	#else:
	get_tree().change_scene_to_file(levels[cur_level])
	file.close()

func _ready() -> void:
	pass # Replace with function body.
