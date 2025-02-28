extends State

@export var move_state: State

func enter() -> void:
	super()
	parent.velocity = Vector2.ZERO  # Reset velocity when entering idle state
	parent.animation_player.play("idle")  # Ensure idle animation plays

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	# If any movement key is held, transition to move_state
	if Input.is_action_pressed("left") or Input.is_action_pressed("right") or \
	   Input.is_action_pressed("up") or Input.is_action_pressed("down"):
		return move_state
	return null
