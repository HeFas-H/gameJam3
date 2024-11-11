extends entity_aizek

const SPEED = 200.0

#@onready var console = $Console

#@onready var projectile = preload("res://nodes/aizek/bullet.tscn")
@onready var player = get_tree().get_nodes_in_group("player")[0]

var state = 0

enum status {
	idle = 0,
	walk = 1,
	attack = 2,
}

var is_attacking = false

func _deploy() -> void:
	anim = $AnimatedSprite2D
	health = 25

func _physics_process(delta: float) -> void:
	
	if player == null:
		queue_free()
		return
	
	match state:
		0:
			anim.play("idle")
		1:
			anim.play("walk")
		2:
			anim.play("attack")
		_:
			anim.play("idle")
	
	if !$ShootDelay.is_stopped():
		return
	
	var direction = (player.position - position).normalized()
	var motion = direction * SPEED * delta
	if position.distance_squared_to(player.position) > 10000:
		position += motion
		state = 1
	else:
		state = 0
	
	if is_attacking and $ShootDelay.is_stopped():
		$ShootDelay.start()
		state = 2
	
	move_and_slide()

func _on_shoot_delay_timeout() -> void:
	Attack()

func Attack():
	if is_attacking:
		player.TakeDamage(damage)

func _on_attack_area_body_entered(body: Node2D) -> void:
	is_attacking = true

func _on_attack_area_body_exited(body: Node2D) -> void:
	is_attacking = false
