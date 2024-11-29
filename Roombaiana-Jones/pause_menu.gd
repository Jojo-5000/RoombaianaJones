extends Control

@onready var main = get_parent().get_parent()  # Get the grandparent node (Level1)

func _ready():
	# Set process_mode to PROCESS_MODE_ALWAYS to allow interaction even when the game is paused
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS

func _on_resume_pressed() -> void:
	main.pausemenu()  # Call the pausemenu function on the grandparent (Level1) to resume the game

func _on_quit_pressed() -> void:
	get_tree().quit()  # Quit the game
