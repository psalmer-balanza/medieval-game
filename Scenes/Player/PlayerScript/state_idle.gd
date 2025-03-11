extends State

@export var move_state: State
@export var attack_state: State

func enter() -> void:
	super()
	parent.velocity = Vector2.ZERO  # Reset velocity when entering idle state
	
	### Play idle animation of the last known direction
	if parent.last_direction.x < 0:
		parent.animation_player.play("idle_left")
	elif parent.last_direction.x > 0:
		parent.animation_player.play("idle_right")
	elif parent.last_direction.y < 0:
		parent.animation_player.play("idle_up")
	elif parent.last_direction.y > 0:
		parent.animation_player.play("idle_down")

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("attack"):
		return attack_state
	return null


func process_frame(delta: float) -> State:
	# If any movement key is held, transition to move_state
	if Input.is_action_pressed("left") or Input.is_action_pressed("right") or \
	   Input.is_action_pressed("up") or Input.is_action_pressed("down"):
		return move_state
	return null
