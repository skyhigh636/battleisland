class_name StateMachine
"""
who knew state machines were actually applicable in code..

State machine initialization
this file handles all the transitions to differing states,
the train depot that sends the trains.
"""
extends Node2D

var current_state: State

@export var starting_state: State

func init() -> void: 
	if starting_state == null:
		for child in get_children():
			if child is State:
				starting_state = child
				break
				
	if starting_state != null:
		change_state(starting_state)

func process_frame(delta: float) -> void:
	if current_state:
		var new_state: State = current_state.process_frame(delta)
		if new_state: change_state(new_state)



func process_input(event: InputEvent) -> void:
	if current_state:
		var new_state: State = current_state.process_input(event)
		if new_state: change_state(new_state)

func  process_physics( delta: float) -> void:
	if current_state:
		var new_state: State = current_state.process_physics(delta)
		if new_state: change_state(new_state)
		
	
func change_state(new_state: State) -> void:
	if current_state:  current_state.exit()
	current_state = new_state
	current_state.enter()
