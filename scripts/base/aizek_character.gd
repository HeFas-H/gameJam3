extends CharacterBody2D

class_name entity_aizek

signal takeDamage(dmg)

var health = 100.0
var damage = 10.0

var anim
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
	emit_signal("takeDamage", dmg)

func Die():
	queue_free()

func _ready() -> void:
	_deploy()
	dmg_timer = Timer.new()
	dmg_timer.autostart = false
	dmg_timer.one_shot = true
	add_child(dmg_timer)
	dmg_timer.connect("timeout", Callable(self, "_timer_dmg_timeout") )
	
func _timer_dmg_timeout() -> void:
	anim.self_modulate = Color(1,1,1,1)
	
func _deploy() -> void:
	pass
