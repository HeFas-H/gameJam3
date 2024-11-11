extends CharacterBody2D

var is_destroy = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += Vector2(0,55500) * delta
		move_and_slide()
	elif !is_destroy:
		is_destroy = true
		self.show()
		$Timer.start()

func _on_timer_timeout() -> void:
	queue_free()
