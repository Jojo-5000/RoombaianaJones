extends Area3D

@export var unlock_message: String = "Double jump unlocked!"
var player : CharacterBody3D

func _on_body_entered(body: Node) -> void:
	# Check if the body that entered is the player (make sure to adjust this if needed)
	if body is CharacterBody3D:
		player = body
		# Unlock double jump (set max_jumps to 2)
		if player != null:
			# Ensure the player only unlocks the double jump once
			if player.max_jumps == 1:  # Only unlock if it's not already unlocked
				player.max_jumps = 2  # Set to 2 for double jump
				print(unlock_message)  # You can display a message here if needed
				# Optionally, you can play a sound or show an effect to indicate the unlock
