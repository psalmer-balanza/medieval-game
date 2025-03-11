class_name State
extends Node
#All the states inherit from this script 
#This scriptis not connected to any nodes


# Hold a reference to the parent so that it can be controlled by the state
var parent: Player
func enter() -> void:
	pass
	
func Enter() -> void:
	pass

func exit() -> void:
	pass
func Exit() -> void:
	pass

func Process(_delta: float) -> State:
	return null
	
func Physics(_delta: float) -> State:
	return null
	
func HandleInput(_event: InputEvent) -> State:
	return null
	
func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
