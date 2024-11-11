extends Control

@onready var slider = $HSlider

func _ready() -> void:
	slider.value = global.volume_scale
	#print(slider.value)
	for i in get_tree().root.get_node("World/Audio").get_children():
		i.volume_db = linear_to_db(global.volume_scale)

func _on_h_slider_value_changed(value: float) -> void:
	global.volume_scale = value
	for i in get_tree().root.get_node("World/Audio").get_children():
		i.volume_db = linear_to_db(global.volume_scale)
