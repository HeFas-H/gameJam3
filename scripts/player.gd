extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var anim = $AnimatedSprite2D
@onready var console = $Console
#@onready var console_trigger = $ConsoleZone

var state = 0

enum status {
	idle = 0,
	walk = 1,
	jump = 2,
	fly = 3,
}

var can_dash = true

func _physics_process(delta: float) -> void:
	if not is_on_floor():
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
	
	if !console.line.has_focus():
	
		if Input.is_action_just_pressed("w") and is_on_floor():
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
		
		#if Input.is_action_just_pressed("dash"):
			#if can_dash:
			#	velocity.x = direction * SPEED * 40
			#	can_dash = false
			#	$DashReload.start()
		
	move_and_slide()


func _on_animation_finished() -> void:
	if state > 1: 
		state = 0

func _on_console_trigger_entered(body: Node2D) -> void:
	console.console_obj.append(body)

func _on_console_trigger_exited(body: Node2D) -> void:
	console.console_obj.erase(body)


func _on_dash_reload() -> void:
	can_dash = true
