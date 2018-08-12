extends Node2D

# Signals
signal send_key_pressed
signal key_side_changed

# Vars
var keys_controlled_list
var keys_in_scene

var hit0
var hit1
var hit2
var keyboard_image
var keyboard

var hit0_playing
var hit1_playing
var hit2_playing

var rotation_amount
var transform_amount

func _ready():
	_initialize_scores()
	
	hit0 = $Hit0
	hit1 = $Hit1
	hit2 = $Hit2
	keyboard_image = $KeyboardImage
	keyboard = $Keyboard
	
	hit0.connect("finished", self, "_hit0_finished_playing")
	hit1.connect("finished", self, "_hit1_finished_playing")
	hit2.connect("finished", self, "_hit2_finished_playing")
	
	hit0_playing = false
	hit1_playing = false
	hit2_playing = false
	
	rotation_amount = .1
	transform_amount = 1

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		Global.change_state(Global.MENU)
	if event is InputEventKey and not event.is_echo():
		emit_signal("send_key_pressed", OS.get_scancode_string(event.scancode))
		_jiggle_keyboard()
		_play_random_sound()

func _process(delta):
	if Global.player_1_data.empty():
		pass
	elif Global.player_2_data.empty():
		pass

func _jiggle_keyboard():
	if randf() > .6:
		rotation_amount = .1
	elif randf() < .4:
		rotation_amount = -.1
	
	keyboard_image.global_rotation_degrees += rotation_amount
	keyboard.global_rotation_degrees += rotation_amount
	
	keyboard_image.global_position.x += transform_amount
	keyboard_image.global_position.y += transform_amount
	keyboard.global_position.x += transform_amount
	keyboard.global_position.y += transform_amount
	
	transform_amount *= -1
	
	randomize()

func _play_random_sound():
	var random_value = randf()
	if(random_value < .33 and !hit0_playing):
		hit0.play()
		hit0_playing = true
	elif(random_value >= .33 and random_value <= .66 and !hit1_playing):
		hit1.play()
		hit1_playing = true
	elif(random_value > .66 and !hit2_playing):
		hit2.play()
		hit2_playing = true

func _hit0_finished_playing():
	hit0_playing = false

func _hit1_finished_playing():
	hit1_playing = false

func _hit2_finished_playing():
	hit2_playing = false

func _initialize_scores():
	Global.player_1_data = ["Q"]
	Global.player_2_data = ["["]

func update_score(key, new_owner):
	if new_owner == Global.LEFT:
		Global.player_1_data.append(key)
		if Global.player_2_data.has(key):
			Global.player_2_data.erase(key)
	elif new_owner == Global.RIGHT:
		Global.player_2_data.append(key)
		if Global.player_1_data.has(key):
			Global.player_1_data.erase(key)
	elif new_owner == Global.NEUTRAL:
		if Global.player_1_data.has(key):
			Global.player_1_data.erase(key)
		if Global.player_2_data.has(key):
			Global.player_2_data.erase(key)
	else:
		print("There's been a problem in the update_score function")
