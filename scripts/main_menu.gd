extends Control

func _ready() -> void:
	if !FileAccess.file_exists(global.PATH):
		$PanelContainer/VBoxContainer/HBoxContainer3/Button.disabled = true
	else:
		$PanelContainer/VBoxContainer/HBoxContainer3/Button.disabled = false
		global.Load()
	$PanelContainer/VBoxContainer/HBoxContainer2/HBoxContainer2/PanelContainer._ready()

func _on_button_start_pressed() -> void:
	global.commands = ["use", "help", "clear"]
	get_tree().change_scene_to_file("res://nodes/worlds/world.tscn")

func _on_button_continue_pressed() -> void:
	print(global.commands)
	get_tree().change_scene_to_file(global.levels[global.cur_level])

func _on_button_exit_pressed() -> void:
	global.Save()
	get_tree().quit()
