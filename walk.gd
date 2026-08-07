class_name PlayerWalkState
extends PlayerState
"""
movement, nothing of note
"""
const SPEED: float = 350.0
func enter() -> void:
	player.animation.play(walk_anim)
	
func process_physics(delta: float) -> State:
	super.process_physics(delta)
	var move_dir = get_move_dir()
	
	if move_dir == 0:
		return idle_state
		
	do_move(move_dir)
	return null
	
	
func process_input(event: InputEvent) -> State:
	super.process_input(event)
	if event.is_action_pressed(jump_key) and player.is_on_floor():
		return jump_state
		#come back to later
		## elif event.is_action_pressed(up_key) and player.is_on_floor() and event.is_action_pressed(jab_key): return upper_state

	
	return null
	
func get_move_dir() -> float:

	return Input.get_axis(left_key,right_key)
	

func do_move(move_dir: float) -> void:
	player.velocity.x = move_toward(player.velocity.x, move_dir * SPEED, SPEED  * 0.15)
	if move_dir < 0:
		player.sprite.flip_h = true
	elif move_dir > 0:
		player.sprite.flip_h = false
