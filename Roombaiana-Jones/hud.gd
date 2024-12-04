extends CanvasLayer

@onready var progress_bar_type1 : ProgressBar = $DustProgressBarType1  # First progress bar
@onready var progress_bar_type2 : ProgressBar = $DustProgressBarType2  # Second progress bar
@onready var progress_bar_type3 : ProgressBar = $DustProgressBarType3  # Third progress bar
@onready var status_label : Label = $StatusLabel  # Reference to the status label

# Method to update the dust progress for all three types
func update_dust_percentage(percentage_type1: float, percentage_type2: float, percentage_type3: float):
	progress_bar_type1.value = percentage_type1  # Set first progress bar's value
	progress_bar_type2.value = percentage_type2  # Set second progress bar's value
	progress_bar_type3.value = percentage_type3  # Set third progress bar's value
	status_label.text = "Dust Collected Type1: %.2f%%\nDust Collected Type2: %.2f%%\nDust Collected Type3: %.2f%%" % [percentage_type1, percentage_type2, percentage_type3]  # Update the label with all three percentages

# Method to show ability unlock status (e.g., double jump unlocked)
func update_status(message: String):
	status_label.text = message  # Set the label text to show a message
