extends CharacterBody2D

class_name entity_aizek

var health = 100

func TakeDamage( dmg ):
	health = health - dmg
	if health <= 0:
		Die()

func Die():
	queue_free()

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
