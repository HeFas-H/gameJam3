extends RigidBody2D

var damage = 15
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer2D.volume_db = linear_to_db(global.volume_scale)

func _on_body_entered(body: Node2D) -> void:
	$AudioStreamPlayer2D.play()
	if body.get_class() == "CharacterBody2D" or body.get_class() == "StaticBody2D":
		body.TakeDamage(damage)
	for i in get_children():
		if i.get_class() != "AudioStreamPlayer2D":
			i.queue_free()

func _on_audio_stream_player_2d_finished() -> void:
	queue_free()
