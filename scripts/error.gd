extends Node2D

var is_errored = false

var damage = 10

@onready var anims = $Anims

func _ready() -> void:
	anims.hide()
	for i in anims.get_children():
		i.play("default")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_errored:
		if body.get_collision_layer_value(2):
			body.TakeDamage(-damage)
		else:
			body.TakeDamage(damage*2)
		$Timer.start()
		is_errored = false
		anims.hide()
	else:
		body.TakeDamage(damage)

func _on_timer_timeout() -> void:
	is_errored = true
	anims.show()
