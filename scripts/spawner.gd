extends Node2D

@onready var npc = preload("res://nodes/aizek/enemy.tscn")

func _on_timer_timeout() -> void:
	var enemy = npc.instantiate()
	get_tree().root.add_child(enemy)
	enemy.global_position = global_position
