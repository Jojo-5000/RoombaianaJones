extends Area3D

@export var dust_value : float = 1.0  # The value of this dust spot, can be adjusted to represent percentage
@export var dust_color : Color = Color(1, 1, 0)  # Just to visualize the dust (optional)
var player : CharacterBody3D
signal dust_collected(amount: float)  # Signal to notify when dust is collected

# Called when the Roomba enters the area
func _on_body_entered(body: Node) -> void:
	if body is CharacterBody3D:  # Check if the body that entered is the player (Roomba)
		player = body
		emit_signal("dust_collected", dust_value)  # Emit signal to update the dust count
		queue_free()  # Remove the dust area from the scene