extends Node2D

@onready var phys = $Node2D
var damage = 15
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	print("er")
	if body.get_class() == "CharacterBody2D":
		body.TakeDamage(damage)
	queue_free()
