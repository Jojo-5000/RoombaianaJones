extends CanvasLayer

@onready var progress_bar : ProgressBar = $DustProgressBar  # Reference to the progress bar
@onready var status_label : Label = $StatusLabel  # Reference to the status label

# Method to update the dust progress
func update_dust_percentage(percentage: float):
	progress_bar.value = percentage  # Set the progress bar's value
	status_label.text = "Dust Collected: %.2f%%" % percentage  # Update the label with the percentage

# Method to show ability unlock status (e.g., double jump unlocked)
func update_status(message: String):
	status_label.text = message  # Set the label text to show a message
