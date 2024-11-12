extends Node2D

var pos = Vector2(0,0)

@onready var sprite = $Sprite

enum types {
	zero = 0,
	one = 1,
	two = 2,
	three = 3,
	four = 4,
	five = 5,
	six = 6,
	seven = 7,
	eight = 8,
	bomb = 9,
}

var type = types.zero
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.frame = 11
	


#func _check():
	#sprite.frame = type
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if !get_parent().is_playable:
		return
	if event.is_action_released("lmb"):
		if sprite.frame == 10: return
		sprite.frame = type
		if type == 9:
			get_parent().is_playable = false
			get_parent().restart()
			return
		get_parent().check_bomb(get_parent().opened + 1)
		get_parent()._check(pos)
	if event.is_action_released("rmb"):
		if sprite.frame == 11:
			get_parent().checked = get_parent().checked + 1
			get_parent().l_mines.text = str(get_parent().mines-get_parent().checked)
			sprite.frame = 10
		elif sprite.frame == 10:
			get_parent().checked = get_parent().checked - 1
			get_parent().l_mines.text = str(get_parent().mines-get_parent().checked)
			sprite.frame = 11
