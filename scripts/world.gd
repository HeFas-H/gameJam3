extends Node2D

@onready var mibik = preload("res://nodes/aizek/mibik.tscn")

func _on_tree_exited() -> void:
	global.Save()

var i = 0
func _on_timer_timeout() -> void:
	$Objects/Spawner.timer.wait_time = 15
	$Objects/Spawner2.timer.wait_time = 15
	$Cutscene.start()

func _on_cutscene_timeout() -> void: #0.877
	if i < 10:
		$Shadow.show()
		$Shadow.scale += Vector2(0.08,0.08)
	else:
		var boss = mibik.instantiate()
		add_child(boss)
		boss.position = Vector2(0, -1200)
		boss.pos = $Shadow.global_position + Vector2(0,-50)
		$Cutscene.stop()
	i+=1
