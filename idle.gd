class_name PlayerIdleState
extends PlayerState

var DECEL_SPEED : float = 300.0
"""
Idle state for idle animation,
only thing here is the input function being useful for actions that should only happen
when standing still
"""
func enter() -> void:
	player.animation.play(idle_anim)

func process_physics(delta: float) -> State:
	super(delta)
	player.velocity.x = move_toward(player.velocity.x,0,DECEL_SPEED * 0.15)
	return null

func process_input(event: InputEvent) -> State:
	super(event)
	if event.is_action_pressed(right_key) or event.is_action_pressed(left_key): return walk_state
	if event.is_action_pressed(jump_key) and player.is_on_floor(): return jump_state
	elif event.is_action_pressed(jab_key) and player.is_on_floor() and event.is_action_pressed("Up"): return upper_state
	elif event.is_action_pressed(jab_key) and player.is_on_floor(): return jab_state
	return null
