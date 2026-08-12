class_name State
extends Node


# Called when the node enters the scene tree for the first time.
func enter() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func exit() -> void:
	pass
# state class

func process_frame(delta: float) -> State:
	return null

func process_input(event: InputEvent) -> State:
	return null
	
func process_physics(delta: float) -> State:
	return null
