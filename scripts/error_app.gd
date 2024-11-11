extends StaticBody2D

@onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_meta("repeat") <= 0:
		timer.queue_free()

func _process(delta: float) -> void:
	pass

var i = 0
func _on_timer_timeout() -> void:
	i += 1
	if i >= get_meta("repeat"):
		timer.stop()
	$AudioStreamPlayer.play()
	var error = self.duplicate()
	error.set_meta("repeat", 0)
	error.global_position = global_position+get_meta("pos")*i
	get_tree().root.add_child(error)
