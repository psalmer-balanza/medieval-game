extends State

@export var fall_state: State
@export var jump_state: State
@export var move_state: State
@export var idle_state: State
func enter() -> void:
	super()

func process_input(event: InputEvent) -> State:
	#if Input.is_action_just_pressed("jump") and parent.is_on_floor():
		#return jump_state
	
	# Check if NO movement keys are being pressed
	if not (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or 
			Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")):
		print("Switching to Idle State")
		return idle_state  # Transition to Idle if no movement input

	return null

func process_physics(delta: float) -> State:
	# This is for direction, takes it from input
	var character_direction = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	).normalized()

	# If there is no movement, transition to Idle
	if character_direction == Vector2.ZERO:
		return idle_state

	# Handle animations based on direction
	if character_direction.x < 0 and character_direction.y == 0: 	#LEFT
		parent.animation_player.play("walk_left")
	elif character_direction.x > 0 and character_direction.y == 0: 	#RIGHT
		parent.animation_player.play("walk_right")
	elif character_direction.y < 0:                               	#UP
		parent.animation_player.play("walk_up")
	elif character_direction.y > 0:                              	#DOWN
		parent.animation_player.play("walk_down")
	
	# Apply movement velocity
	parent.velocity = character_direction * parent.movement_speed
	
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
