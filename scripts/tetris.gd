extends Node2D

@onready var block_i = preload("res://nodes/tetris/long_block.tscn")
@onready var block_l = preload("res://nodes/tetris/l_block.tscn")
@onready var block_z = preload("res://nodes/tetris/zet_block.tscn")
@onready var block_o = preload("res://nodes/tetris/square_block.tscn")
@onready var block_t = preload("res://nodes/tetris/t_block.tscn")

@onready var blocks = [block_l, block_i, block_z, block_o, block_t]

@onready var marker = $Marker
@onready var next_block = $NextBlock

var queue = {
	0: {rotation = PI/2, type = 4, pos_x = 48, dir = Vector2(3,0), scale = Vector2(1,1)},
	2: {rotation = 0, type = 1, pos_x = 16, dir = Vector2(0,3), scale = Vector2(1,1)},
	3: {rotation = PI/2, type = 2, pos_x = 16*7, dir = Vector2(-3,0), scale = Vector2(-1,1)},
	4: {rotation = PI/2, type = 3, pos_x = 16*4, dir = Vector2(3,0), scale = Vector2(1,1)},
	1: {rotation = PI/2, type = 4, pos_x = 16*11, dir = Vector2(3,0), scale = Vector2(1,1)},
	5: {rotation = PI/2, type = 0, pos_x = 16*16, dir = Vector2(-3,0), scale = Vector2(-1,1)},
	6: {rotation = 0, type = 0, pos_x = 16*5, dir = Vector2(0,3), scale = Vector2(-1,1)},
	7: {rotation = PI/2, type = 3, pos_x = 16*12, dir = Vector2(3,0), scale = Vector2(1,1)},
	8: {rotation = PI/2, type = 1, pos_x = 16*14, dir = Vector2(3,0), scale = Vector2(1,1)},
	9: {rotation = PI/2, type = 4, pos_x = 16*9, dir = Vector2(3,0), scale = Vector2(1,1)},
	10: {rotation = 0, type = 2, pos_x = 16*18, dir = Vector2(0,3), scale = Vector2(-1,1)},
	11: {rotation = -PI/2, type = 4, pos_x = 16*13, dir = Vector2(-3,0), scale = Vector2(1,1)},
	12: {rotation = PI/2, type = 3, pos_x = 16*4, dir = Vector2(3,0), scale = Vector2(1,1)},
	13: {rotation = 0, type = 0, pos_x = 16*9, dir = Vector2(0,-3), scale = Vector2(-1,-1)},
	14: {rotation = PI/2, type = 2, pos_x = 16*17, dir = Vector2(-3,0), scale = Vector2(-1,1)},
	15: {rotation = PI/2, type = 1, pos_x = 16*4, dir = Vector2(3,0), scale = Vector2(1,1)},
	16: {rotation = -PI/2, type = 0, pos_x = 16*14, dir = Vector2(3,0), scale = Vector2(-1,1)},
	17: {rotation = 0, type = 4, pos_x = 16*18, dir = Vector2(0,3), scale = Vector2(1,1)},
	18: {rotation = PI/2, type = 3, pos_x = 16*8, dir = Vector2(3,0), scale = Vector2(1,1)},
	19: {rotation = 0, type = 4, pos_x = 16*12, dir = Vector2(0,3), scale = Vector2(1,1)},
	20: {rotation = 0, type = 0, pos_x = 16*17, dir = Vector2(0,3), scale = Vector2(1,1)},
	21: {rotation = PI/2, type = 2, pos_x = 16*3, dir = Vector2(3,0), scale = Vector2(1,1)},
	22: {rotation = PI/2, type = 4, pos_x = 16*7, dir = Vector2(3,0), scale = Vector2(1,1)},
	23: {rotation = -PI/2, type = 0, pos_x = 16*2, dir = Vector2(3,0), scale = Vector2(-1,1)},
	24: {rotation = PI/2, type = 1, pos_x = 16*8, dir = Vector2(3,0), scale = Vector2(1,1)},
	25: {rotation = PI/2, type = 3, pos_x = 16*18, dir = Vector2(3,0), scale = Vector2(1,1)},
	26: {rotation = 0, type = 0, pos_x = 16*13, dir = Vector2(0,3), scale = Vector2(-1,1)},
}

var i = 0
func _on_timer_timeout() -> void:
	var block = blocks[queue[i].type].instantiate()
	block.rotation = queue[i].rotation
	block.scale = queue[i].scale
	block.position = Vector2(queue[i].pos_x, 0)
	block.dir = queue[i].dir
	marker.add_child(block)
	i = i + 1
	if queue.size() <= i:
		$Timer.stop()
		return
	next_block.frame = queue[i].type

func _on_victory_entered(_body: Node2D) -> void:
	global.commands.append("gravity")
	global.cur_level = 4
	get_tree().change_scene_to_file("res://nodes/worlds/world2.tscn")

func _on_delay_timeout() -> void:
	pass

func _on_tree_exited() -> void:
	global.Save()
