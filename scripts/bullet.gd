extends RigidBody2D

var damage = 15
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D" or body.get_class() == "StaticBody2D":
		body.TakeDamage(damage)
	queue_free()
