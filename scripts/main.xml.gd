extends Node2D

var coins = 200
var item = 0
var feed = false

var food = load("res://scenes/food.xml")
var fish = load("res://scenes/fish_1.xml")
var fish_2 = load("res://scenes/fish_2.xml")
var fish_3 = load("res://scenes/fish_3.xml")

var shop

func _ready():
	get_node("coins").set_text(str(coins))
	shop = get_node("gui_shop/shop")
	set_process_input(true)
	
func _input(ev):
	if ev.is_pressed() && !ev.is_echo():
		if feed:
			var food_new = food.instance()
			food_new.set_pos(Vector2(ev.pos.x,ev.pos.y-50))
			add_child(food_new)
			feed = false
			get_node("helper").set_text("")
			
		if item == 1:
			var fish_new = fish.instance()
			coins -= 10
			add_fish(fish_new,ev.pos)
			
		elif item == 2:
			var fish_new = fish_2.instance()
			coins -= 10
			add_fish(fish_new,ev.pos)
			
		elif item == 3:
			var fish_new = fish_3.instance()
			coins -= 10
			add_fish(fish_new,ev.pos)
			
func add_fish(current_fish,pos):
	current_fish.set_pos(Vector2(pos))
	add_child(current_fish)
	get_node("coins").set_text(str(coins))
	item = 0
	get_node("helper").set_text("")

func _on_btn_shop_pressed():
	feed = false
	shop.show()

func _on_btn_feed_pressed():
	item = 0
	feed = true
	get_node("helper").set_text("Place the food.")

func _on_btn_buy_1_pressed():
	shop.hide()
	if coins >= 10:
		get_node("helper").set_text("Place the fish.")
		item = 1
	else:
		get_node("helper").set_text("You don't have enough coins!")
		

func _on_btn_buy_2_pressed():
	shop.hide()
	if coins >= 10:
		get_node("helper").set_text("Place the fish.")
		item = 2
	else:
		get_node("helper").set_text("You don't have enough coins!")
		
func _on_btn_buy_3_pressed():
	shop.hide()
	if coins >= 10:
		get_node("helper").set_text("Place the turtle.")
		item = 3
	else:
		get_node("helper").set_text("You don't have enough coins!")