extends PanelContainer

@onready var slider = $VBoxContainer/HSlider
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slider.value = db_to_linear(global.volume_scale)
	for i in get_tree().root.get_node("World/Audio").get_children():
		i.volume_db = global.volume_scale

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_h_slider_value_changed(value: float) -> void:
	global.volume_scale = linear_to_db(value)
	for i in get_tree().root.get_node("World/Audio").get_children():
		i.volume_db = global.volume_scale
