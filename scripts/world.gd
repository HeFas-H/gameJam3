extends Node2D

@onready var mibik = preload("res://nodes/aizek/mibik.tscn")

func _on_tree_exited() -> void:
	global.Save()

var i = 0
func _on_timer_timeout() -> void:
	$Objects/Spawner.timer.wait_time = 15
	$Objects/Spawner2.timer.wait_time = 15
	$Cutscene.start()

func CutScene():
	$Cutscene2.process_mode = Node.PROCESS_MODE_INHERIT
	$Cutscene2.start()

func _on_cutscene_timeout() -> void: #0.877
	if i < 10:
		$Shadow.show()
		$Shadow.scale += Vector2(0.08,0.08)
		if i == 1:
			var boss = mibik.instantiate()
			add_child(boss)
			boss.position = Vector2(0, -1200)
			boss.pos = $Shadow.global_position + Vector2(0,-50)
	else:
		$Cutscene.stop()
	i+=1

func _on_cutscene_2_timeout() -> void:
	$FinalCutscene_nodes.process_mode = Node.PROCESS_MODE_INHERIT
	$FinalCutscene_nodes.show()
	$FinalCutscene_nodes/AnimatedSprite2D.play("default")
	$Audio.process_mode = Node.PROCESS_MODE_INHERIT
	$Audio/MainOst.process_mode = Node.PROCESS_MODE_DISABLED
	$Audio/SounddddddddErrror.process_mode = Node.PROCESS_MODE_INHERIT

func _on_final_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://nodes/worlds/final.tscn")
