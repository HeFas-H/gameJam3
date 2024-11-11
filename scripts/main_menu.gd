extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.Load()
	if !global.is_loaded:
		$PanelContainer/VBoxContainer/HBoxContainer2/Button.disabled = true
	else:
		$PanelContainer/VBoxContainer/HBoxContainer2/Button.disabled = false
	$PanelContainer/VBoxContainer/HBoxContainer2/HBoxContainer2/PanelContainer._ready()

func _on_button_start_pressed() -> void:
	global.commands = ["use", "help", "clear"]
	get_tree().change_scene_to_file("res://nodes/worlds/world.tscn")

func _on_button_continue_pressed() -> void:
	get_tree().change_scene_to_file(global.levels[global.cur_level])

func _on_button_exit_pressed() -> void:
	global.Save()
	get_tree().quit()
