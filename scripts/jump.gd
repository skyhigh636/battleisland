class_name PlayerJumpState
extends PlayerState

const SPEED: float = 150.0
const AIR_SPEED: float = 100.0
const JUMP_FORCE: float = -300.0 
"""
jumping, similar enough to walk script just including the y axis
can get mad wacky if vars are changed
"""
func enter() -> void: 
	super()
	player.velocity.y = JUMP_FORCE
	player.animation.play(jump_anim)
	
func process_physics(delta: float) -> State:
	super(delta)
	var move_dir = get_move_dir()
	if move_dir != 0:
		do_move(move_dir,delta)
		
	if player.is_on_floor():
		if move_dir == 0:
			return idle_state
		else:
			return walk_state
	return null
	

func get_move_dir() -> float:

	return Input.get_axis(left_key,right_key)
	

func do_move(move_dir: float,delta: float) -> void:
	player.velocity.x = move_toward(player.velocity.x, move_dir * SPEED, AIR_SPEED  * delta)
