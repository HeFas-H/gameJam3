extends CharacterBody2D

@onready var pos = get_meta("point_1") + position
#var dir = true
var deltatime = 200

func _ready() -> void:
	set_meta("point_1", get_meta("point_1") + position )
	set_meta("point_2", get_meta("point_2") + position )

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.position != pos:
		position = Vector2(move_toward(self.position.x, self.pos.x, deltatime*delta), move_toward(self.position.y, self.pos.y, deltatime*delta))
	else:
		if pos == get_meta("point_1"):
			pos = get_meta("point_2")
		else:
			pos = get_meta("point_1")
	move_and_slide()
	
