extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.frame = get_meta("tutorial")
	if get_meta("tutorial") < global.tutorial:
		queue_free()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("lmb"):
		global.tutorial += 1
		queue_free()
