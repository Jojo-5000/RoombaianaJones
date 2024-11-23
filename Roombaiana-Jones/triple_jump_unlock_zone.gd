extends Area3D

@export var unlock_message: String = "Triple jump unlocked!"
var player : CharacterBody3D

func _on_body_entered(body: Node) -> void:
	# Check if the body that entered is the player
	if body is CharacterBody3D:
		player = body
		# Unlock triple jump (set max_jumps to 3)
		if player != null:
			# Ensure the player only unlocks the triple jump once
			if player.max_jumps == 2:  # Only unlock if it's not already unlocked
				player.max_jumps = 3  # Set to 3 for triple jump
				print(unlock_message)  # Optionally, display a message
				# Optionally, you can play a sound or show an effect to indicate the unlock
