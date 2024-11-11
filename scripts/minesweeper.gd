extends Node2D

@export var map_size = Vector2(16,16)
@export var mines = 4
#hack - Чтобы взломать
@onready var cell = preload("res://nodes/cell.tscn")
#в консоль писать координаты for open

var opened = 0
var checked = 0

@onready var l_timer = $Timer
@onready var l_mines = $Mines

var is_playable = true
var mines_matrix = []

var start_time = Time.get_ticks_msec()/1000

func _ready() -> void:
	l_mines.text = str(mines-checked)
	for x in range(0, map_size.x):
		mines_matrix.append([])
		for y in range(0, map_size.y):
			var _c = cell.instantiate()
			_c.position = Vector2(x*16,y*16)
			_c.pos = Vector2(x,y)
			self.add_child(_c)
			mines_matrix[x].append(null)
			mines_matrix[x][y] = _c
	place_bomb()

func _process(delta: float) -> void:
	l_timer.text = str(Time.get_time_string_from_unix_time(Time.get_ticks_msec()/1000 - start_time))

func check_bomb( num ):
	opened = num
	#l_mines.text = str(mines-checked)

func restart():
	$RestartTimer.start()

func place_bomb():
	for i in mines:
		while(true):
			var rnd_x = randi_range(0,map_size.x-1)
			var rnd_y = randi_range(0,map_size.y-1)
			
			if mines_matrix[rnd_x][rnd_y].type != 9:
				mines_matrix[rnd_x][rnd_y].type = 9
				break
	
	for i in mines_matrix:
		for el in i:
			if el.type == 9:
				continue
			var count = 0
			var pos = Vector2(0,0)
			for x in range(-1,2):
				for y in range(-1,2):
					pos = Vector2(x,y)
					if (el.pos+pos).x >= 0 and (el.pos+pos).y >= 0 and (el.pos+pos).x < map_size.x and (el.pos+pos).y < map_size.y:
						if mines_matrix[el.pos.x+x][el.pos.y+y].type == 9:
							count = count + 1
			el.type = count
	is_playable = true

func _check( id ):
	var pos = Vector2(0,0)
	for x in range(-1,2):
		for y in range(-1,2):
			pos = Vector2(x,y)
			if (id+pos).x >= 0 and (id+pos).y >= 0 and (id+pos).x < map_size.x and (id+pos).y < map_size.y:
				if mines_matrix[id.x+x][id.y+y].sprite.frame == mines_matrix[id.x+x][id.y+y].type:
					continue
				if mines_matrix[id.x+x][id.y+y].type == 0:
					if mines_matrix[id.x+x][id.y+y].sprite.frame == mines_matrix[id.x+x][id.y+y].type:
						continue
					mines_matrix[id.x+x][id.y+y].sprite.frame = mines_matrix[id.x+x][id.y+y].type
					opened = opened + 1
					_check(Vector2(id.x+x, id.y+y))
				elif mines_matrix[id.x][id.y].type == 0:
					opened = opened + 1
					mines_matrix[id.x+x][id.y+y].sprite.frame = mines_matrix[id.x+x][id.y+y].type
	if opened + mines == map_size.x*map_size.y:
		$VictoryDelay.start()
		EXPLOSION()

@onready var EXPLOSION_SPRITE = $EXPL_SPRITE
func EXPLOSION():
	$Audio/AudioStreamPlayer.play()
	EXPLOSION_SPRITE.global_position = get_global_mouse_position()
	EXPLOSION_SPRITE.scale = Vector2(0.1,0.1)
	EXPLOSION_SPRITE.show()
	$EXPL_TIMER.start()
	EXPLOSION_SPRITE.play("default")

func _on_delay_timeout() -> void:
	global.commands.append("destroy")
	global.cur_level = 2
	get_tree().change_scene_to_file("res://nodes/worlds/world1.tscn")

func _on_restart_timer_timeout() -> void:
	start_time = Time.get_ticks_msec()/1000
	for i in mines_matrix:
		for el in i:
			el.type = 0
			el.sprite.frame = 11
	check_bomb(0)
	checked = 0
	l_mines.text = str(mines-checked)
	place_bomb()


func _on_expl_timer_timeout() -> void:
	if !EXPLOSION_SPRITE.scale.x > 1.2:
		EXPLOSION_SPRITE.scale += Vector2(0.4,0.4)
	else:
		$EXPL_TIMER.stop()
