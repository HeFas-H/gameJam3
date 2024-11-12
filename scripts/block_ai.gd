extends CharacterBody2D

var dir = Vector2(0,3)

@onready var trigger = $Damage
@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var signa = preload("res://nodes/tetris/sing.tscn")

func _ready() -> void:
	var s = signa.instantiate()
	get_tree().root.add_child(s)
	s.global_position = global_position
	for i in trigger.get_children():
		i.position = i.position+dir*2
	var timer = Timer.new()
	timer.autostart = false
	timer.one_shot = true
	add_child(timer)
	timer.start(0.8)
	timer.connect("timeout", Callable(self, "_timer_timeout") )

var gravity = Vector2(0,200)
func _timer_timeout():
	gravity = Vector2(0,1000)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += gravity * delta
		move_and_slide()

func _on_triggered(_body: Node2D) -> void:
	if player == _body:
		get_tree().reload_current_scene()
