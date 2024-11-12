extends CharacterBody2D

@onready var select = $Select

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var anim = $AnimatedSprite2D
@onready var console = $Console
#@onready var console_trigger = $ConsoleZone

var state = 0

var can_jump = true

enum status {
	idle = 0,
	walk = 1,
	jump = 2,
	fly = 3,
}

@onready var anim_error = $AnimatedSprite2D2

func _ready() -> void:
	$AnimatedSprite2D2/AudioStreamPlayer.volume_db = linear_to_db(global.volume_scale)
	anim_error.global_position = get_tree().root.get_node("World/Camera2D").global_position
	anim_error.show()
	anim_error.play("default")
	

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		if $DashReload.is_stopped() and can_jump:
			$DashReload.start()
		velocity += global.gravity * delta
		if state != 2:
			state = 3
		
	match state:
		0:
			anim.play("idle")
		1:
			anim.play("walk")
		2:
			anim.play("jump")
		3:
			anim.play("fly")
		_:
			anim.play("idle")

	if is_on_floor() and !can_jump:
		can_jump = true

	if !console.line.has_focus():
	
		if Input.is_action_just_pressed("w") and can_jump:
			can_jump = false
			velocity.y = JUMP_VELOCITY
			state = 2
		
		var direction := Input.get_axis("a", "d")
		
		if direction == 1:
			anim.flip_h = false
		elif direction == -1:
			anim.flip_h = true
		
		if direction:
			velocity.x = direction * SPEED
			if state == 0:
				state = 1
		else:
			if state == 1:
				state = 0
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()


func _on_animation_finished() -> void:
	if state > 1: 
		state = 0

func _on_console_trigger_entered(body: Node2D) -> void:
	select.global_position = body.global_position
	select.show()
	console.console_obj.append(body)

func _on_console_trigger_exited(body: Node2D) -> void:
	select.hide()
	console.console_obj.erase(body)

func _on_dash_reload() -> void:
	can_jump = false

func _on_error_animation_finished() -> void:
	anim_error.hide()
