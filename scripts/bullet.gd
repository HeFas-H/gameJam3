extends RigidBody2D

var collision_layers = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision_layer = collision_layers
	collision_mask = collision_layers


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node) -> void:
	pass # Replace with function body.
