extends CanvasLayer

signal can_move

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimatedSprite2D.play()
	if(int($Timer.time_left) == 0):
		hide()
	pass


func _on_timer_timeout():
	emit_signal("can_move")
	pass # Replace with function body.
