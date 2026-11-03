extends Area2D

@export var speed := 300.0
@export var max_distance := 250.0
@onready var bullet: AnimatedSprite2D = $bullet
var direction := Vector2.RIGHT
var start_position: Vector2

func _ready() -> void:
	visible = false
	



func launch(shoot_direction: Vector2) -> void:
	direction = shoot_direction
	start_position = global_position
	visible = true
	




func _physics_process(delta):
	global_position += direction *speed * delta


	if global_position.distance_to(start_position) >= max_distance:
		queue_free()

func _on_Bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()
	
