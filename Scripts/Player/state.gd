class_name State
extends Node
#All the states inherit from this script 
#This scriptis not connected to any nodes
@export var animation_name: String
@export var move_speed: float = 300


# Hold a reference to the parent so that it can be controlled by the state
var parent: Player

func enter() -> void:
	parent.animation_player.play(animation_name)

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
