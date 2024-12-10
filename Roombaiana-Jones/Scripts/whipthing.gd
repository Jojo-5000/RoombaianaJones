extends Area3D

signal exploded
signal catch(body_entered)

@export var whip_velocity = 40
@export var g = Vector3.DOWN * 10

var velocity = Vector3.ZERO

func _physics_process(delta):
	velocity += g * delta
	look_at(transform.origin + velocity.normalized(), Vector3.UP)
	transform.origin += velocity * delta

func _on_Shell_body_entered(body):
	emit_signal("exploded", transform.origin)
	queue_free()

func _on_body_entered(body: Node3D):
	print("body_entered", body)
	if (body.is_in_group("movable_blocks")):
		catch.emit(body.name)
