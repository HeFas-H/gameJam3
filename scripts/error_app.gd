extends StaticBody2D

@onready var timer = $Timer
@onready var timer2 = $Timer2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer2.start(get_meta("time"))
	if get_meta("repeat") <= 0:
		timer.queue_free()

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
	error.reparent(self)

func _on_timer_2_timeout() -> void:
	if visible == false:
		$AudioStreamPlayer.play()
		show()
	if !get_meta("repeat") <= 0:
		timer.start()
