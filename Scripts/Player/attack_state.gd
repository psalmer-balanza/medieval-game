extends State

@export var move_state: State
@export var idle_state: State
@export var attack_sound: AudioStream
@export_range(1, 20, 0.5) var decelerate_speed: float = 5.0

@onready var audio_player: AudioStreamPlayer2D = $"../../Node2D/AudioStreamPlayer2D"

var attack_done: bool = false  # Controls attack progress internally

func enter() -> void:
	super()

	attack_done = false  # Reset attack flag on new attack entry
	print("Entered attack state")

	# Play attack sound
	if audio_player:
		audio_player.stream = attack_sound
		audio_player.pitch_scale = randf_range(0.5, 1.5)
		audio_player.play()

	# Select correct attack animation based on direction
	var dir = parent.last_direction
	var attack_anim = "attack_down"
	if dir.x < 0:
		attack_anim = "attack_left"
	elif dir.x > 0:
		attack_anim = "attack_right"
	elif dir.y < 0:
		attack_anim = "attack_up"
	elif dir.y > 0:
		attack_anim = "attack_down"

	# Play attack animation
	parent.animation_player.play(attack_anim)

	# Ensure no duplicate signal connections
	if parent.animation_player.animation_finished.is_connected(_on_attack_finished):
		parent.animation_player.animation_finished.disconnect(_on_attack_finished)

	# Connect with one-shot so it auto-disconnects
	parent.animation_player.animation_finished.connect(_on_attack_finished, CONNECT_ONE_SHOT)

func _on_attack_finished(anim_name: StringName) -> void:
	attack_done = true  # Mark attack as finished
	print("Attack animation finished")

func process_input(event: InputEvent) -> State:
	if not attack_done:
		return self  # Stay until attack animation finishes

	# Move if input detected
	if event.is_action_pressed("left") or event.is_action_pressed("right") or \
	   event.is_action_pressed("up") or event.is_action_pressed("down"):
		return move_state

	return idle_state  # Default to idle if no input

func process_frame(delta: float) -> State:
	parent.velocity -= parent.velocity * decelerate_speed * delta  # Smooth stop

	if attack_done:
		# Check if player is moving
		var move_dir = Vector2(
			Input.get_axis("left", "right"),
			Input.get_axis("up", "down")
		).normalized()

		if move_dir != Vector2.ZERO:
			return move_state  # Move if input
		else:
			return idle_state  # Else idle

	return self  # Continue attacking if not done
