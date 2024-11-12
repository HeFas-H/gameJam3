extends entity_aizek

const SPEED = 300.0

#@onready var console = $Console

var max_health = health
@onready var projectile = preload("res://nodes/aizek/bullet.tscn")
@onready var anim_error = $AnimatedSprite2D2
@onready var health_bar = $Bar/Progress


var state = 0

enum status {
	idle = 0,
	walk = 1,
}

var last_dir = Vector2(0,1)

func _deploy() -> void:
	connect("takeDamage", Callable(self, "_damaged") )
	$AnimatedSprite2D2/AudioStreamPlayer.volume_db = linear_to_db(global.volume_scale)
	$AudioStreamPlayer.volume_db = linear_to_db(global.volume_scale)
	health = 100.0
	damage = 12.0
	max_health = health
	anim = $AnimatedSprite2D
	anim_error.global_position = get_tree().root.get_node("World/Camera2D").global_position
	anim_error.show()
	anim_error.play("default")

func _damaged(dmg) -> void:
	if max_health >= health:
		health_bar.scale.x = health/max_health
	else:
		health_bar.scale.x = 1
	if dmg > 0:
		$AudioStreamPlayer.play()

func _physics_process(_delta: float) -> void:

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

func Die():
	get_tree().reload_current_scene()

func shoot():
	var bullet = projectile.instantiate()
	get_tree().root.get_tree().root.get_node("World").add_child(bullet)
	bullet.damage = damage
	bullet.global_position = global_position
	bullet.linear_velocity = last_dir*800

func _on_shoot_delay_timeout() -> void:
	shoot()

func _on_animated_sprite_2d_2_animation_finished() -> void:
	anim_error.hide()
