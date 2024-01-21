extends Node2D

var car_1 = preload("res://Scenes/cop_bot/car_1.tscn")
var car_2 = preload("res://Scenes/cop_bot/car_2.tscn")
var car_3 = preload("res://Scenes/cop_bot/car_3.tscn")
var car_4 = preload("res://Scenes/cop_bot/car_4.tscn")
enum car_title {car1, car2, car3, car4}
var current_car
var car_type = 0

signal car_regeneration(car_type)

#lane 1 starts from the bottom
var lane_positions = {
	"lane_1": 408,
	"lane_2": 391,
	"lane_3": 370,
	"lane_4": 355,
	"lane_5": 339,
	"lane_6": 258,
	"lane_7": 247,
	"lane_8": 231,
	"lane_9": 167,
	"lane_10": 151,
	"lane_11": 135,
	"lane_12": 72,
	"lane_13": 56,
	"lane_14": 40,
	"lane_15": 24
}

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in lane_positions.keys():
		random_generation()
		var current_car_instance = current_car_matching()
		var lane_position = lane_positions[i]
		current_car_instance.position.y = lane_position
		var timer_length = randi() % 12 + 3
		var timer = Timer.new()
 
		# Set the wait time for the timer
		timer.wait_time = timer_length
		timer.autostart = true
		# Connect the timeout signal to the callback function and pass the custom_data variable
		timer.timeout.connect(_on_timer_timeout.bind(timer_length, timer, lane_position))    
		# Add the timer to the scene or a relevant node
		get_tree().get_root().call_deferred("add_child", timer)
		#get_tree().get_root().call_deferred("add_child", current_car_instance)
			
		# Start the timer
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func random_generation():
	car_type = randi() % 4
	random_car_creation()
	
func random_car_creation():
	match car_type:
		0:
			current_car = car_title.car1
		1:
			current_car = car_title.car2
		2:
			current_car = car_title.car3
		3:
			current_car = car_title.car4
			
func current_car_matching():
	match current_car:
		car_title.car1:
			return car_1.instantiate()
		car_title.car2:
			return car_2.instantiate()
		car_title.car3:
			return car_3.instantiate()
		car_title.car4:
			return car_4.instantiate()

	
func _on_timer_timeout(time_served, timer, lane_position):
	random_generation()
	var current_car_instance = current_car_matching()
	current_car_instance.position.y = lane_position
	get_tree().get_root().call_deferred("add_child", current_car_instance)
	timer.start()
	
	

func game_over(isHit):
	get_tree().call_group("cars", "queue_free")
	if(isHit):
		get_tree().change_scene_to_file("res://Scenes/end_scene.tscn")	
	else:
		get_tree().change_scene_to_file("res://Scenes/win_scene.tscn")	
		


func _on_player_hit():
	game_over(true)
	pass # Replace with function body.


func _on_area_2d_area_entered(area):
	if(area.name == "Player"):
		game_over(false)
	pass # Replace with function body.


func _on_hud_can_move():
	$Player.can_move()
	pass # Replace with function body.


func _on_honk_timer_timeout():
	
	var honk_type = randi() % 3
	if(honk_type == 0):
		$Honk1.play()
		await get_tree().create_timer(1).timeout
		$Honk1.stop()
		pass
	elif(honk_type == 1):
		$Honk2.play()
		await get_tree().create_timer(1).timeout
		$Honk2.stop()
		pass
	elif(honk_type == 2):
		$Honk3.play()
		await get_tree().create_timer(1).timeout
		$Honk3.stop()
		pass
	$HonkTimer.start()
