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
	
	

func catched(catchname: String):
	print(catched)
	if (name == catchname):
		pull_towards_player(0.2)
	

func pull_towards_player(pull_strength: float):
	var direction = (followpoint.global_position - global_transform.origin).normalized()
	var motion = direction * pull_strength
	apply_impulse(motion)
