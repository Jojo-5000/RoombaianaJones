extends RigidBody3D

@export var followpoint : Node
var deltaglob : float
var speed: float = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	deltaglob = delta

func pull_towards_player(pull_strength: float):
	var direction = (followpoint.global_position - global_transform.origin)
	var motion = direction * pull_strength
	apply_impulse(motion)

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("Whipability"):
		print("caught!")
		pull_towards_player(1.3)
	pass
