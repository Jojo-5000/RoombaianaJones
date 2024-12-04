extends Node

@onready var hud : Node = $"../HUD"  # Reference to the HUD node (the CanvasLayer)
@onready var roomba : CharacterBody3D = $"../Character/RoombaianaJones"  # Reference to the player
@onready var double_jump_unlock_zone : Area3D = $"../DoubleJumpUnlocker/DoubleJumpUnlockZone"  # The unlock zone for double jump

var total_dust_collected : float = 0.0
var total_dust_in_room : float = 100.0  # Assume you know how much dust is in the room

var unlock_percentage : float = 80.0  # 80% dust collected to unlock double jump

func _ready():
	# Listen for dust collected signal from DustArea nodes
	for dust_area in get_tree().get_nodes_in_group("dust_areas"):
		dust_area.connect("dust_collected", Callable(self, "_on_dust_collected"))

	# Initially hide the unlock zone
	double_jump_unlock_zone.visible = false
	double_jump_unlock_zone.collision_layer = 0  # Set to 0 to disable the collision layer
	double_jump_unlock_zone.collision_mask = 0  # Set to 0 to disable collision mask

func _on_dust_collected(amount: float):
	total_dust_collected += amount  # Update total dust collected
	update_hud()

	# Check if 80% dust is collected to unlock double jump
	var dust_percentage = (total_dust_collected / total_dust_in_room) * 100
	if dust_percentage >= unlock_percentage:
		double_jump_unlock_zone.visible = true
		double_jump_unlock_zone.collision_layer = 1  # Enable collision for this layer
		double_jump_unlock_zone.collision_mask = 1  # Allow collision with the player
		update_hud("Please empty dust compartment")  # Show unlock message in HUD

	# You can add more thresholds here for other abilities

func update_hud(message: String = ""):
	var dust_percentage = (total_dust_collected / total_dust_in_room) * 100
	hud.update_dust_percentage(dust_percentage)  # Update dust progress
	if message != "":
		hud.update_status(message)  # Update the status message
