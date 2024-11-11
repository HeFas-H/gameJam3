extends Node

var commands = ["help", "clear", "use"] #gravity destroy %hack
var gravity = Vector2(0, 980)

var tutorial = 0

var cur_level = 0
var volume_scale = 0.3
const PATH = "user://gamejam_troyan.save"

func Save():
	var file = FileAccess.open(PATH, FileAccess.WRITE)
	file.store_64(cur_level)
	file.store_double(volume_scale)
	file.store_csv_line(commands)
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
	volume_scale = file.get_double()
	commands = Array(file.get_csv_line())
	file.close()
