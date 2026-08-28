extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var start_pos: Vector2

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var gun: AnimatedSprite2D = $Sprite/gun

@onready var sprite: AnimatedSprite2D = $Sprite


var gun_start_pos: Vector2

func _ready() -> void:
	gun_start_pos = gun.position

func reset_gun() -> void: 
	#resets gun to its original position, however does this regardless of if player is facing left, 
	#figure that out later
	#or don't
	#let it ride
	
	gun.position = gun_start_pos
	gun.rotation_degrees = 0


func _process(delta:float) -> void:
	if is_on_floor():
		pass
	else: 
		
		if Input.is_action_pressed("Down"):
			sprite.play("jump")
			sprite.play("air_down")
			gun.rotation_degrees = 90
			gun.position.y = +10
			gun.position.x = -1
		elif Input.is_action_just_released("Down"):
			reset_gun()
			sprite.play("jump")
			

	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	var direction := Input.get_axis("Left", "Right")
	if direction > 0:
		sprite.flip_h = false
		gun.position.x = abs(gun.position.x) # keep on right side
		gun.flip_h = false
		
	elif direction < 0:
		sprite.flip_h = true
		gun.position.x = -abs(gun.position.x) # move to left side
		gun.flip_h = true

	if is_on_floor():
		if direction == 0:
			sprite.play("default")
		else:
			sprite.play("walk")
		
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
