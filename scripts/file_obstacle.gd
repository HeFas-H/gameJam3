extends StaticBody2D

@onready var anim = $AnimatedSprite2D
var pos = Vector2(0,0)
var deltatime = 8
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Ghost.global_rotation = 0
	$Ghost.global_position = global_position + Vector2(-12,15)
	if !get_meta("can_disappear"):
		$Ghost.queue_free()
	pos = pos + global_position
	anim.frame = randi_range(0,2)
	anim.global_rotation = 0
	$CollisionShape2D.global_rotation = 0
	$Area2D/CollisionShape2D.global_rotation = 0

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
	if get_meta("can_reload"):
		visible = false
		collision_layer = 0
		$Area2D.collision_mask = 0
		$Visible.start()
	else:
		queue_free()

func _on_visible_timeout() -> void:
	visible = true
	$Area2D.collision_mask = 3
	collision_layer = 1
