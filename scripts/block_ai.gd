extends CharacterBody2D

var dir = Vector2(0,3)

func _ready() -> void:
	for i in trigger.get_children():
		i.position = i.position+dir*3

@onready var trigger = $Damage
@onready var player = get_tree().get_nodes_in_group("player")[0]

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		move_and_slide()

func _on_triggered(_body: Node2D) -> void:
	if player == _body:
		get_tree().reload_current_scene()

var delay = false
func _on_delay_timeout() -> void:
	delay = true
