extends CharacterBody2D
@export var Bullet : PackedScene

const SPEED = 200.0
const JUMP_VELOCITY = -300.0
var start_pos: Vector2

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var gun: AnimatedSprite2D = $Sprite/gun

@onready var sprite: AnimatedSprite2D = $Sprite

var facing_left := false

var gun_start_pos: Vector2

func _ready() -> void:
	gun_start_pos = gun.position

func reset_gun() -> void: 
	gun.position = gun_start_pos
	if facing_left:
		gun.position.x = -abs(gun_start_pos.x)
	else:
		gun.position.x = abs(gun_start_pos.x)
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
			gun.position.x = -0.5
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
		facing_left = false
		sprite.flip_h = false
		gun.flip_h = false
		gun.position.x = abs(gun_start_pos.x)

	elif direction < 0:
		facing_left = true
		sprite.flip_h = true
		gun.flip_h = true
		gun.position.x = -abs(gun_start_pos.x)

	if is_on_floor():
		if direction == 0:
			sprite.play("default")
		else:
			sprite.play("walk")
		
	if Input.is_action_just_pressed("Shoot"):
		print("hello")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
