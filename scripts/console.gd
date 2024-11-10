extends Control

@onready var text = $Panel/App/VBoxContainer/Text
@onready var line = $Panel/App/VBoxContainer/LineEdit

var split_command = []
var command = ""
var focus = false
var console_obj = []
@onready var up_panel = $Panel/App/HBoxContainer

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("lmb"):
		if focus == false:
			line.focus_mode = 0
	if Input.is_action_pressed("lmb"):
		if up_panel.has_focus():
			global_position = get_global_mouse_position()
	if Input.is_action_just_released("lmb"):
		up_panel.focus_mode = 0
		up_panel.focus_mode = 1
	if Input.is_action_just_pressed("console"):
		visible = !visible
		position = Vector2(-570,-420)

func _parse():
	split_command = command.split(" ")
	split_command.resize(2)
	
	match split_command[0]:
		"gravity":
			if global.commands.has("gravity"):
				console_gravity(split_command[1].to_float())
			else:
				console_denied()
		"destroy":
			if global.commands.has("destroy"):
				console_destroy()
			else:
				console_denied()
		"use":
			console_use()
		"clear":
			console_clear()
		"help":
			console_help()
		_:
			console_error()

func console_denied():
	_text_edit("You don`t have permission!")

func console_use():
	if !console_obj.is_empty() and console_obj[0] != null:
		if console_obj[0].get_meta("coms").has("use"):
			console_obj[0].Use()
			_text_edit("use")
		else:
			_text_edit("Invalid target!")
	else:
		_text_edit("Invalid target!")
	
func console_destroy():
	if !console_obj.is_empty() and console_obj[0] != null:
		if console_obj[0].get_meta("coms").has("destroy"):
			console_obj[0].Destroy()
			_text_edit("destroy")
		else:
			_text_edit("Invalid target!")
	else:
		_text_edit("Invalid target!")

func console_error():
	_text_edit("Error! Try to use 'help'")

func console_help():
	for i in global.commands:
		_text_edit(i)
	
func console_clear():
	text.text = ""

func console_gravity( value ): #set gravity
	_text_edit("gravity " + str(value))
	global.gravity = Vector2(0, value*1000)

func _text_edit( txt ):
	text.text = txt + "\n" + text.text 

func _entered(new_text: String) -> void:
	command = line.text
	line.text = ""
	_parse()

func _on_exit_pressed() -> void:
	visible = false
	position = Vector2(-570,-420)

func _on_mouse_entered() -> void:
	line.focus_mode = 2
	focus = true

func _on_mouse_exited() -> void:
	focus = false
