extends Node2D

func _ready() -> void:
	$AnimatedSprite2D.frame = get_meta("tutorial")
	if get_meta("tutorial") < global.tutorial:
		queue_free()
	else:
		show()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("lmb"):
		global.tutorial += 1 #get_meta("tutorial)+1
		queue_free()
