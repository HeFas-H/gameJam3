extends StaticBody2D

var i = 0

func _ready() -> void:
	pass

func _on_timer_timeout() -> void:
	if i < get_meta("size"):
		i+=1
		scale += Vector2(0.3, 0.3)
	else:
		$Timer.stop()
