extends Area3D

# Reference to the wall
var wall: StaticBody3D
var default_state: CSGCombiner3D
var pressed_state: CSGCombiner3D
var is_pressed: bool = false  # Track if the button has been pressed

func _ready():
	# Find the wall node
	wall = get_parent().get_node("MazeWall") # Change "Wall" to the name of your wall node
	default_state = $ButtonUnPressed  # Change to the name of your default sprite node
	pressed_state = $ButtonPressed  # Change to the name of your pressed sprite node
	pressed_state.visible = false  # Hide pressed sprite initially

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player") and not is_pressed: # Make sure your player is in the "player" group
		if wall:
			wall.queue_free()  # Removes the wall
			default_state.visible = false  # Hide the default sprite
			pressed_state.visible = true  # Show the pressed sprite
			is_pressed = true  # Mark as pressed
