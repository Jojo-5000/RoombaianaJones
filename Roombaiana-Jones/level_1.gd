extends Node3D

@onready var pause_menu = $CanvasLayer/PauseMenu
@onready var camera = $Character/RoombaianaJones/Camera3D  # Assuming your camera node is directly a child of Level1
var paused = false

func _process(delta):
	# Handle pause/unpause with both Escape key or custom Pause action
	if Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("Pause"):
		pausemenu()

func pausemenu():
	if paused:
		# Unpause the game
		pause_menu.hide()
		Engine.time_scale = 1  # Resume normal time
		# Restore mouse capture for camera control
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
		# Enable camera movement (allow processing)
		camera.set_process(true)  # Enable camera movement processing
	else:
		# Pause the game
		pause_menu.show()
		Engine.time_scale = 0  # Freeze game time
		# Make the mouse visible for UI interaction
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		# Disable camera movement (disable processing)
		camera.set_process(false)  # Stop camera movement processing

	paused = !paused
