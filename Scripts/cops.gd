class_name Cops

extends Area2D



var speed = 20
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed * delta

	pass





func _on_visible_on_screen_notifier_2d_screen_exited():
	if global_position.x > get_viewport().size.x:
		queue_free()
	pass # Replace with function body.


func _on_area_entered(area):
	if(area.name == "Player" or area.name == "LineOfDeath"):
		queue_free()
	pass # Replace with function body.
