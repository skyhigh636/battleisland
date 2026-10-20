extends Area2D

var speed = 1.5
var distance = 2

func _physics_process(delta):
	pass


func gun_shoot():
	position += transform.x * speed * distance

func _on_Bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()
	
