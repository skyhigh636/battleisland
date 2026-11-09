extends Area2D

@export var speed := 300.0
@export var max_distance := 250.0
@onready var bullet: AnimatedSprite2D = $projectile
var direction := Vector2.RIGHT
var start_position: Vector2

func _ready() -> void:
	visible = false
	



func launch(shoot_direction: Vector2) -> void:
	direction = shoot_direction.normalized()
	start_position = global_position
	visible = true
	if shoot_direction == Vector2(0, -1):
		bullet.rotation = 11.0
	elif shoot_direction == Vector2(0, 1):
		bullet.rotation = -11.0


func _physics_process(delta):
	global_position += direction *speed * delta


	if global_position.distance_to(start_position) >= max_distance:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	queue_free()
	
