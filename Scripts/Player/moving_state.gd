extends State

@export var move_state: State
@export var idle_state: State
@export var attack_state: State

func enter() -> void:
	super()

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("attack"):
		return attack_state
	return null

func process_frame(delta: float) -> State:
	# This is for direction, takes it from input
	var character_direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()

	# **Store last movement direction before checking for idle**
	if character_direction != Vector2.ZERO:
		parent.last_direction = character_direction  # Store the direction BEFORE returning

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
	parent.move_and_slide()
	
	return null #Stay in move state while moving
