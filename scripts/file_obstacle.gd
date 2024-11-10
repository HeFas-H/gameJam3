extends StaticBody2D

@onready var anim = $AnimatedSprite2D
var pos = Vector2(0,0)
var deltatime = 8
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pos = pos + global_position
	anim.frame = randi_range(0,2)
	anim.global_rotation = 0
	$CollisionShape2D.global_rotation = 0

#constant_linear_velocity 

func _process(delta: float) -> void:
	if self.position != pos:
		position = Vector2(move_toward(self.position.x, self.pos.x, deltatime), move_toward(self.position.y, self.pos.y, deltatime))

func _on_area_2d_body_entered(body: Node2D) -> void:
	if self.position != pos:
		return
	if get_meta("can_disappear"):
		$Timer.start()

func _on_timer_timeout() -> void:
	queue_free()
