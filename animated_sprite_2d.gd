extends 

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var gun: AnimatedSprite2D = $Sprite/gun

const SPEED := 200.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction := Input.get_axis("Left", "Right")
	
	if direction > 0:
		sprite.flip_h = false
		gun.flip_h = false
		gun.position.x = abs(gun.position.x) # keep on right side
	elif direction < 0:
		sprite.flip_h = true
		gun.flip_h = true
		gun.position.x = -abs(gun.position.x) # move to left side


	if is_on_floor():
		if direction == 0:
			sprite.play("default")
		else:
			sprite.play("walk")
	else:

		sprite.play("jump")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
