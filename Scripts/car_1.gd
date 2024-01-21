extends Cops

var direction = 50
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += direction * delta
	$AnimatedSprite2D.play("right")

