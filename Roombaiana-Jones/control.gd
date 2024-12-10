extends Control

var player : Node
var previtem = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = %Character/RoombaianaJones
	$Timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if previtem != player.item:
		show()
		$Timer.start()
	if player.item == 1:
		$ColorRect.color = Color(1, 1, 1, 1)
		$ColorRect2.color = Color(0, 0, 0, 0)
	elif player.item == 2:
		$ColorRect2.color = Color(1, 1, 1, 1)
		$ColorRect.color = Color(0, 0, 0, 0)
	previtem = player.item
	pass

func _on_timer_timeout():
	hide()
