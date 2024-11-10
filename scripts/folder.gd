extends Control


var i = 0

func _on_timer_timeout() -> void:
	if i < get_meta("size"):
		i+=1
		scale += Vector2(0.05, 0.05)
	else:
		$Timer.stop()
