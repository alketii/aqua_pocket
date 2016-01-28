extends RigidBody2D

var side
var toggle_side
var speed
var speed_y
var angle
var feed = false
var look_pos
var born = false

export var current_food = 5
export var max_food = 5
export var eat_amount = 1
export var eat_time = 5
export var critical = 2

var take_food = true

func _ready():
	randomize()
	side = randi() % 2
	get_node("Timer").set_wait_time(eat_time)
	get_node("Timer").start()
	set_process_input(true)
	set_fixed_process(true)

func _fixed_process(delta):

	if current_food > max_food:
		current_food = max_food
		
	if current_food <= critical:
		get_node("hungry").show()
	else:
		get_node("hungry").hide()
		
	if current_food == 0:
		get_node("Sprite").set_flip_v(true)
		set_mode(1)
	
	
	if get_pos().x < 30:
		side = 1
		
	if get_pos().x > 994:
		side = 0
	
	if get_linear_velocity().x < 30 && get_linear_velocity().x > 0:
		side = 1
	
	if get_linear_velocity().x > -30 && get_linear_velocity().x < 0:
		side = 0
		
	if side == 0:
		speed = randi() % 120
		speed_y = 10 - randi() % 26
		set_linear_velocity(Vector2(-speed,speed_y))
		get_node("Sprite").set_flip_h(false)
		side = -1
	elif side == 1:
		speed = randi() % 120
		speed_y = 10 - randi() % 26
		set_linear_velocity(Vector2(speed,speed_y))
		get_node("Sprite").set_flip_h(true)
		side = -1
		
	if get_pos().x < 800 && get_pos().x > 100:
		toggle_side = randi() % 201
		if toggle_side == 200:
			side = randi() % 2
	
	if feed && current_food < max_food:
		angle = get_pos().angle_to_point(look_pos) + deg2rad(180)
		set_linear_velocity(Vector2(200,200).rotated(angle))
		if int(get_pos().x) in range(look_pos.x-10,look_pos.x+10) && int(get_pos().y) in range(look_pos.y-10,look_pos.y+10):
			feed = false
			side = randi() % 2
	else:
		feed = false
	
func _input(ev):
	if ev.pos.y < 600:
		if ev.is_pressed() && !ev.is_echo():
			if get_parent().feed:
				if int(get_pos().x) in range(ev.pos.x-300,ev.pos.x+300) && int(get_pos().y) in range(ev.pos.y-300,ev.pos.y+300):
					look_pos = ev.pos
					feed = true

func _on_TextureButton_pressed():
	if born:
		if get_pos().x < 512:
			set_linear_velocity(Vector2(300,0))
			get_node("Sprite").set_flip_h(true)
		else:
			set_linear_velocity(Vector2(-300,0))
			get_node("Sprite").set_flip_h(false)
	born = true

func _on_fish_body_enter( body ):
	body.queue_free()
	current_food += 10

func _on_Timer_timeout():
	current_food -= 1

	print(current_food)
