extends entity_aizek

const SPEED = 300.0

@onready var anim = $AnimatedSprite2D
#@onready var console = $Console

@onready var projectile = preload("res://nodes/aizek/bullet.tscn")

var state = 0

enum status {
	idle = 0,
	walk = 1,
}

var last_dir = Vector2(0,1)

func _physics_process(delta: float) -> void:
	
	match state:
		0:
			anim.play("idle")
		1:
			anim.play("walk")
		_:
			anim.play("idle")
	
	var input_dir = Input.get_vector("a", "d", "w", "s")
	velocity = input_dir * SPEED
	
	if input_dir.x == 1:
		anim.flip_h = false
	elif input_dir.x == -1:
		anim.flip_h = true
	
	if input_dir != Vector2(0,0):
		last_dir = input_dir
		state = 1
	else:
		state = 0

	move_and_slide()

func shoot():
	var bullet = projectile.instantiate()
	get_tree().root.add_child(bullet)
	bullet.global_position = global_position
	bullet.linear_velocity = last_dir*800

func _on_shoot_delay_timeout() -> void:
	shoot()
