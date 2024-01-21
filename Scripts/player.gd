extends Area2D

var speed = 50
var screen_size

signal hit
var can_move_player = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("up")
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(can_move_player == true):
		var velocity = Vector2.ZERO # The player's movement vector.
		if Input.is_action_pressed("right"):
			velocity.x += 1
			$AnimatedSprite2D.play("right")
		if Input.is_action_pressed("left"):
			velocity.x -= 1
			$AnimatedSprite2D.play("left")
		if Input.is_action_pressed("down"):
			velocity.y += 1
			$AnimatedSprite2D.play("down")
		if Input.is_action_pressed("up"):
			velocity.y -= 1
			$AnimatedSprite2D.play("up")

		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
		else:
			$AnimatedSprite2D.stop()
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, screen_size)


func _on_area_entered(area):
	print("hit " + area.name)
	can_move_player=false
	$AnimatedSprite2D.play("explosion")
	$AudioStreamPlayer2D.play()
	await get_tree().create_timer(1).timeout
	emit_signal("hit")


func can_move():
	can_move_player = true
