extends State

@export var move_state: State
@export var idle_state: State

var attack_done: bool = false  # Flag to track animation completion

func enter() -> void:
	super()
	attack_done = false  # Reset attack state
	
	# Determine attack animation based on last direction
	var dir = parent.last_direction
	var attack_anim = "attack_down"  # Default

	if dir.x < 0 and dir.y == 0:
		attack_anim = "attack_left"
	elif dir.x > 0 and dir.y == 0:
		attack_anim = "attack_right"
	elif dir.y < 0:
		attack_anim = "attack_up"
	elif dir.y > 0:
		attack_anim = "attack_down"

	# Play attack animation and connect to animation finished signal
	parent.animation_player.play(attack_anim)
	parent.animation_player.animation_finished.connect(_on_attack_finished, CONNECT_ONE_SHOT)

func _on_attack_finished(anim_name):
	attack_done = true  # Mark attack as finished

func process_input(event: InputEvent) -> State:
	# Prevent attack spamming by ignoring input until animation is done
	if not attack_done:
		return self  
	
	# If attack is done, return to movement or idle based on input
	if event.is_action_pressed("left") or event.is_action_pressed("right") or event.is_action_pressed("up") or event.is_action_pressed("down"):
		return move_state
	return idle_state

func process_frame(delta: float) -> State:
	# Only transition after attack is finished
	if attack_done:
		var character_direction = Vector2(
			Input.get_axis("left", "right"),
			Input.get_axis("up", "down")
		).normalized()
		
		if character_direction == Vector2.ZERO:
			return idle_state
		return move_state
	
	return self  # Stay in attack state until animation finishes
