extends CharacterBody3D

@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5
@export var gravity : float = -10
@export var max_jumps : int = 1  # Start with 1 jump (adjustable to 2 once unlocked)
@export var camera : Camera3D  # Reference to the Camera3D node

var jump_count : int = 1  # Tracks the current jump count (starts at 1, indicating first jump available)
var is_grounded : bool = false

func _ready():
	# Ensure the camera is set if it's not already set in the inspector
	if camera == null:
		camera = $Camera3D  # Assuming Camera3D is a child of the CharacterBody3D

func _physics_process(delta: float) -> void:
	# Check if we are on the floor
	is_grounded = is_on_floor()

	# Apply gravity (applies when in the air)
	if not is_grounded:
		velocity.y += gravity * delta
	else:
		# Reset Y velocity when grounded
		velocity.y = 0

	# Handle jumping
	if Input.is_action_just_pressed("Jump"):
		# First jump: Only allowed if grounded and jump count is 1
		if is_grounded and jump_count == 1:
			velocity.y = JUMP_VELOCITY
			jump_count += 1  # Increment jump count for first jump
			print("First jump!")

		# Subsequent jumps (double/triple): Only allowed if mid-air and jump count is less than max jumps
		elif not is_grounded and jump_count < max_jumps:
			velocity.y = JUMP_VELOCITY
			jump_count += 1  # Increment jump count on valid mid-air jump
			print("Subsequent jump!")

	# Get the input direction based on player movement (W, A, S, D or arrow keys)
	var input_dir := Input.get_vector("Left", "Right", "Up", "Down")  # Horizontal/Vertical axis
	var direction := Vector3.ZERO

	if input_dir != Vector2.ZERO:
		# Get camera's forward and right directions
		var camera_forward = camera.global_transform.basis.z  # Camera's forward direction (positive Z-axis)
		var camera_right = camera.global_transform.basis.x  # Camera's right direction (X-axis)
		
		# Normalize the directions to remove any scaling factors
		camera_forward.y = 0  # Ignore vertical movement (Y-axis)
		camera_right.y = 0  # Ignore vertical movement (Y-axis)

		camera_forward = camera_forward.normalized()
		camera_right = camera_right.normalized()

		# Calculate the direction based on the camera's facing
		if input_dir.y > 0:  # Forward movement (W or Up arrow)
			direction += camera_forward
		if input_dir.y < 0:  # Backward movement (S or Down arrow)
			direction -= camera_forward
		if input_dir.x > 0:  # Right movement (D or Right arrow)
			direction += camera_right
		if input_dir.x < 0:  # Left movement (A or Left arrow)
			direction -= camera_right

		# Normalize the final direction to avoid faster diagonal movement
		direction = direction.normalized()

		# Apply the movement direction
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		# If there's no input, decelerate smoothly to stop
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	# Apply the movement and slide while considering gravity
	move_and_slide()

	# Reset jump count when landing on the ground
	if is_grounded:
		# Only reset jump count after the player has landed and is on the ground
		if jump_count > 1:
			jump_count = 1  # Reset jump count after touching the ground to allow new jump
			print("Landed, reset jump count!")
