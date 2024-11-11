extends Node2D

#@onready var mibik = preload("mibik")

func _on_tree_exited() -> void:
	global.Save()

func _on_timer_timeout() -> void:
	$Objects/Spawner.timer.wait_time = 15
	$Objects/Spawner2.timer.wait_time = 15
	#var boss = mibik.
