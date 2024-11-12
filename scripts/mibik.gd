extends StaticBody2D

var health = 250
var damage = 10
var speed = 200

@onready var flash = preload("res://nodes/aizek/boss_projectile.tscn")
@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var anim = $AnimatedSprite2D
var dmg_timer

func TakeDamage( dmg ):
	health = health - dmg
	if health <= 0:
		Die()
	if dmg > 0:
		anim.self_modulate = Color(1,0.2,0.2,1)
	else:
		anim.self_modulate = Color(0.2,1,0.2,1)
	dmg_timer.start(0.2)

func Die():
	for i in get_tree().root.get_node("World").get_children():
		i.process_mode = Node.PROCESS_MODE_DISABLED
	get_tree().root.get_node("World").CutScene()
	

func _ready() -> void:
	dmg_timer = Timer.new()
	dmg_timer.autostart = false
	dmg_timer.one_shot = true
	add_child(dmg_timer)
	dmg_timer.connect("timeout", Callable(self, "_timer_dmg_timeout") )
	
func _timer_dmg_timeout() -> void:
	anim.self_modulate = Color(1,1,1,1)

var state = 0

enum status {
	idle = 0,
	attack = 1,
}

var deltatime = 16
var pos = Vector2(0,0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if self.global_position != pos:
		global_position = Vector2(move_toward(self.global_position.x, self.pos.x, deltatime), move_toward(self.global_position.y, self.pos.y, deltatime))

	match state:
		0:
			anim.play("idle")
		1:
			anim.play("attack")
		_:
			anim.play("idle")
	if health < 150:
		speed = 400
			
func _on_timer_timeout() -> void:
	state = 1

func _on_animated_sprite_2d_animation_finished() -> void:
	if state == 2:
		state = 0
	else:
		state = 2
		$Tok.play()
		var lightbolt = flash.instantiate()
		get_tree().root.get_node("World").add_child(lightbolt)
		lightbolt.damage = damage
		lightbolt.global_position = global_position + Vector2(-50, 0)
		lightbolt.phys.linear_velocity = lightbolt.global_position.direction_to(player.global_position)*speed
		lightbolt.look_at(player.global_position)
