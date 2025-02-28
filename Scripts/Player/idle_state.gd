extends State

@export var fall_state: State
@export var jump_state: State
@export var move_state: State

func enter() -> void:
	super()
	parent.velocity = Vector2.ZERO  # Reset velocity when entering idle state
	parent.animation_player.play("idle")  # Ensure idle animation plays

func process_input(event: InputEvent) -> State:
	# Allow jumping from idle
	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
		return jump_state
	
	# If any movement key is held, transition to move_state
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or \
	   Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down"):
		return move_state

	return null

func process_physics(delta: float) -> State:
	parent.move_and_slide()  # Ensures the player remains in place on slopes
	return null
