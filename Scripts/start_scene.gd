extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$StartMusic.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_texture_button_pressed():
	$Startbuttonsound.play()
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")
	pass # Replace with function body.
