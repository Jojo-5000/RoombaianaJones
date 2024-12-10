extends Area3D

@export var whip_velocity = 40
@export var g = Vector3.DOWN * 10

var velocity = Vector3.ZERO

func _physics_process(delta):
	velocity += g * delta
	look_at(transform.origin + velocity.normalized(), Vector3.UP)
	transform.origin += velocity * delta
