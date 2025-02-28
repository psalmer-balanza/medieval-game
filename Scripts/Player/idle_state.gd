extends State

@export
var fall_state: State
@export
var jump_state: State
@export
var move_state: State


func enter() -> void:
	super()
	parent.velocity.x = 0
	parent.velocity.y = 0

func process_input(event: InputEvent) -> State:
	#if Input.is_action_just_pressed('jump') and parent.is_on_floor():
		#return jump_state
	if Input.is_action_just_pressed('left') or Input.is_action_just_pressed('right'):
		return move_state
	return null

func process_physics(delta: float) -> State:
	parent.move_and_slide()
	return null
	
"""

class_name Player extends CharacterBody2D

var move_speed : float = 100.0

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	var direction : Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	velocity = direction * move_speed
	
	pass
#called every physics tip 	
func _physics_process(delta):
	move_and_slide()
	
"""
