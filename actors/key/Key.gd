extends Node2D

# Signals
signal defeated

# Enums
enum { LEFT, NEUTRAL, RIGHT }

# Consts

# Vars
export(NodePath) var node0 # Adjacent keys that can be attacked.
export(NodePath) var node1 # Will need to be checked if they are null before use,
export(NodePath) var node2 # as some keys will only have two adjacent keys.
export(NodePath) var node3
export(NodePath) var node4
export(NodePath) var node5
export var power = 100 # Strength of the current key

var label
var animation_player
var timer

var nodes_attached

var key_name
var side
var player_last_attacked_by

var can_press_again

func _ready():
	label = $Label
	animation_player = $AnimationPlayer
	timer = $Timer
	
	timer.connect("timeout", self, "_on_Timer_timeout")
	
	key_name = self.name
	
	# Account for Comma, Period, Semicolon, BraceLeft, Equal, and Minus
	# being completely spelled out
	if Global.key_names_to_replace.has(key_name):
		match key_name:
			"Comma":
				key_name = ","
			"Period":
				key_name = "."
			"Semicolon":
				key_name = ";"
			"BraceLeft":
				key_name = "["
			"Equal":
				key_name = "="
			"Minus":
				key_name = "-"
			_:
				pass
	
	side = NEUTRAL
	can_press_again = true
	
	nodes_attached = [node0, node1, node2, node3, node4, node5]
	
	# Set default animation
	animation_player.play("n_unpressed")
	
	# Create the key name
	_create_key_name()

func change_side(new_side):
	side = new_side

func _create_key_name():
	label.text = key_name
	
	# The below code to be used when appropriate assets have been created
	"""
	match key_name:
		"a":
			pass
		"b":
			pass
		"c":
			pass
		"d":
			pass
		"e":
			pass
		"f":
			pass
		"g":
			pass
		"h":
			pass
		"i":
			pass
		"j":
			pass
		"k":
			pass
		"l":
			pass
		"m":
			pass
		"n":
			pass
		"o":
			pass
		"p":
			pass
		"q":
			pass
		"r":
			pass
		"s":
			pass
		"t":
			pass
		"u":
			pass
		"v":
			pass
		"w":
			pass
		"x":
			pass
		"y":
			pass
		"z":
			pass
		_:
			# Do nothing
			pass
	"""

func _process(delta):
	# Check to see if the key has been defeated
	if power < 1:
		emit_signal("defeated", key_name, player_last_attacked_by)	
	
	_attack()

func pressed(key):
	if(key == self.name and can_press_again):
		_play_pressed_animation()
		can_press_again = false
		timer.start()

func _play_pressed_animation():
	match side:
		NEUTRAL:
			animation_player.play("n_pressed")
		LEFT:
			animation_player.play("l_pressed")
		RIGHT:
			animation_player.play("r_pressed")
		_:
			print("There's a problem with the side variable!")
	
	pass

func _attack():
	
	pass

func _on_Timer_timeout():
	can_press_again = true
	match side:
		NEUTRAL:
			animation_player.play("n_unpressed")
		LEFT:
			animation_player.play("l_unpressed")
		RIGHT:
			animation_player.play("r_unpressed")
		_:
			print("There's a problem with the side variable!")
