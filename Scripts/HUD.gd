extends CanvasLayer

signal can_move

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = "Start in " + str(int($Timer.time_left))
	pass


func _on_timer_timeout():
	emit_signal("can_move")
	hide()
	pass # Replace with function body.
