extends Node2D

func _ready() -> void:
	if !FileAccess.file_exists(global.PATH):
		$ContinueBtn/Button.disabled = true
		$ContinueBtn.self_modulate = Color(0.5,0.5,0.5,1)
	else:
		$ContinueBtn/Button.disabled = false
		global.Load()
	$SettingsBtn/Control._ready()

func _on_button_start_pressed() -> void:
	global.commands = ["use", "help", "clear"]
	global.cur_level = 0
	get_tree().change_scene_to_file("res://nodes/worlds/world.tscn")

func _on_button_continue_pressed() -> void:
	get_tree().change_scene_to_file(global.levels[global.cur_level])

func _on_button_exit_pressed() -> void:
	global.Save()
	get_tree().quit()


func _on_continue_m_entered() -> void:
	if FileAccess.file_exists(global.PATH):
		$ContinueBtn.self_modulate = Color(1,1,1,0.7)


func _on_newgame_m_entered() -> void:
	$NewGameBtn.self_modulate = Color(1,1,1,0.7)


func _on_quite_m_entered() -> void:
	$QuiteBtn.self_modulate = Color(1,1,1,0.7)



func _on_continue_m_exited() -> void:
	if FileAccess.file_exists(global.PATH):
		$ContinueBtn.self_modulate = Color(1,1,1,1)

func _on_newgame_m_exited() -> void:
	$NewGameBtn.self_modulate = Color(1,1,1,1)

func _on_quite_m_exited() -> void:
	$QuiteBtn.self_modulate = Color(1,1,1,1)
