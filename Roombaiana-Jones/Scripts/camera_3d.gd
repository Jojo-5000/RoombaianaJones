extends Camera3D

@export var player : Node3D  # The player node to follow
@export var rotation_speed : float = 0.001  # Mouse sensitivity for rotation
@export var distance : float = 5.0  # Distance from the player
@export var close_distance : float = 2.0
@export var height : float = 2.0  # Height offset for the camera
@export var smooth_factor : float = 1.1  # Smoothness for camera movement
@export var aiming : bool = false

var yaw : float = 0.0  # Rotation around the Y-axis (horizontal)
var pitch : float = 0.0  # Rotation around the X-axis (vertical)
var current_position : Vector3 = Vector3.ZERO  # Current camera position

func _ready():
	# Initially, let's just make the mouse visible and not captured for debugging
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # Change this for testing

func _process(delta: float) -> void:
	if player:
		# Get the mouse movement (relative motion, not absolute position)
		var mouse_velocity = Input.get_last_mouse_velocity()
		
		# Adjust yaw and pitch based on mouse movement
		yaw -= mouse_velocity.x * rotation_speed
		pitch -= mouse_velocity.y * rotation_speed

		# Clamp the pitch to prevent the camera from flipping upside down
		pitch = clamp(pitch, -80.0, 80.0)

		# Calculate the direction vector for the camera
		var direction = Vector3(
			cos(deg_to_rad(pitch)) * sin(deg_to_rad(yaw)),
			sin(deg_to_rad(pitch)),
			cos(deg_to_rad(pitch)) * cos(deg_to_rad(yaw))
		)

		var target_position = player.global_transform.origin + Vector3(0, height, 0) - direction * distance
		
		if (aiming):
			target_position = player.global_transform.origin + Vector3(0, height, 0) - direction * close_distance
			
		# Smoothly interpolate the camera's position towards the target position using lerp()
		current_position = current_position.lerp(target_position, smooth_factor)
		
		look_at(player.global_transform.origin + Vector3(0, height, 0), Vector3.UP)
		# Update the camera's position
		global_transform.origin = current_position

		# Always make the camera look at the player
		
