class_name Player
extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0
var start_pos: Vector2

var bullet_scene: PackedScene = preload("res://Scenes/bullet.tscn")
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var gun: AnimatedSprite2D = $Sprite/gun
@onready var sprite: AnimatedSprite2D = $Sprite

# X Y LOGIC: 
# Y: +10 IS DOWN -10 IS UP
# X: +1 IS LEFT -1 IS RIGHT

var facing_left := false

var gun_start_pos: Vector2

func _ready() -> void:
	gun_start_pos = gun.position

func reset_gun() -> void: 
	gun.position = gun_start_pos
	if facing_left:
		gun.position.x = -abs(gun_start_pos.x)
		gun.flip_h = true
	else:
		gun.position.x = abs(gun_start_pos.x)
	gun.rotation_degrees = 0

func _process(delta:float) -> void:
	if is_on_floor():
		reset_gun()
		if Input.is_action_pressed("Up") && facing_left == false:
			gun.rotation_degrees = -90
			gun.position.y = -10
			gun.position.x = +0.4
		elif Input.is_action_pressed("Up") && facing_left == true:
			gun.rotation_degrees = +90
			gun.position.y = -10
			gun.position.x = +0.4

	else: 
		
		if Input.is_action_pressed("Down") && facing_left == false:
			sprite.play("air_down")
			gun.rotation_degrees = 90
			gun.position.y = +6
			gun.position.x = -0.4
		elif Input.is_action_pressed("Down") && facing_left == true: 
			sprite.play("jump")
			sprite.play("air_down")
			gun.rotation_degrees = -90
			gun.position.y = +6
			gun.position.x = -0.4
		elif Input.is_action_just_released("Down") :
			reset_gun()
			sprite.play("jump")
		elif Input.is_action_pressed("Up") && facing_left == false:
			sprite.play("up_air")
			gun.rotation_degrees = -90
			gun.position.y = -10
			gun.position.x = +0.4
		elif Input.is_action_pressed("Up") && facing_left == true:
			sprite.play("up_air")
			gun.rotation_degrees = +90
			gun.position.y = -10
			gun.position.x = +0.4
		elif Input.is_action_just_released("Up"):
			reset_gun()
			sprite.play("jump")
		elif Input.is_action_pressed("Jump"):
			sprite.play("jump")
			


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_pressed("Shoot"):
		var new_bullet := bullet_scene.instantiate()
		
		get_tree().current_scene.add_child(new_bullet)
		new_bullet.global_position = gun.global_position
		
		#shoot direction
		var shoot_direction := Vector2.ZERO
		if Input.is_action_pressed("Down") and is_on_floor() == false:
			shoot_direction = Vector2.DOWN
		elif Input.is_action_pressed("Up"):
			shoot_direction = Vector2.UP
		elif facing_left:
			shoot_direction = Vector2.LEFT
		elif facing_left ==false:
			shoot_direction = Vector2.RIGHT
		new_bullet.launch(shoot_direction)
		
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
			if Input.is_action_pressed("Up"):
				sprite.play("up")
			else:
				sprite.play("default")
		elif Input.is_action_pressed("Up"):
			sprite.play("up_walk")
		else:
			sprite.play("walk")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
