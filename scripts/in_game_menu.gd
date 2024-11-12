extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		visible = !visible
		get_tree().paused = !get_tree().paused

func _on_button_continue_pressed() -> void:
	visible = !visible
	get_tree().paused = !get_tree().paused

func _on_button_exit_pressed() -> void:
	global.Save()
	get_tree().change_scene_to_file("res://nodes/worlds/main_menu.tscn")
	

func _on_continue_m_entered() -> void:
	$ContinueBtn.self_modulate = Color(1,1,1,0.7)

func _on_quite_m_entered() -> void:
	$QuiteBtn.self_modulate = Color(1,1,1,0.7)


func _on_continue_m_exited() -> void:
	$ContinueBtn.self_modulate = Color(1,1,1,1)

func _on_quite_m_exited() -> void:
	$QuiteBtn.self_modulate = Color(1,1,1,1)
