extends Node2D

# Signals
signal defeated

# Enums

# Consts

# Vars
export(NodePath) var node0 # Adjacent keys that can be attacked.
export(NodePath) var node1 # Will need to be checked if they are null before use,
export(NodePath) var node2 # as some keys will only have two adjacent keys.
export(NodePath) var node3
export(NodePath) var node4
export(NodePath) var node5

var actual_node0
var actual_node1
var actual_node2
var actual_node3
var actual_node4
var actual_node5

var actual_node_list

export(int) var power = 40 # Strength of the current key
export(int) var health = 100

var label
var animation_player
var timer
var attack_delay

var key_name # What's actually displayed on the key
var side
var player_last_attacked_by

var can_press_again
var can_attack

func _ready():
	label = $Label
	animation_player = $AnimationPlayer
	timer = $Timer
	attack_delay = $AttackDelay
	
	timer.connect("timeout", self, "_on_Timer_timeout")
	attack_delay.connect("timeout", self, "_on_AttackDelay_timeout")
	
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
	
	if Global.player_1_data.has(key_name):
		side = Global.LEFT
	elif Global.player_2_data.has(key_name):
		side = Global.RIGHT
	else:
		side = Global.NEUTRAL
	
	can_press_again = true
	can_attack = true
	actual_node_list = []
	
	# Create the key name
	_create_key_name()
	
	_set_actual_nodes()

func _create_key_name():
	label.text = key_name

func _set_actual_nodes():
	if node0 != null:
		actual_node0 = get_node(node0)
		actual_node_list.append(actual_node0)
	if node1 != null:
		actual_node1 = get_node(node1)
		actual_node_list.append(actual_node1)
	if node2 != null:
		actual_node2 = get_node(node2)
		actual_node_list.append(actual_node2)
	if node3 != null:
		actual_node3 = get_node(node3)
		actual_node_list.append(actual_node3)
	if node4 != null:
		actual_node4 = get_node(node4)
		actual_node_list.append(actual_node4)
	if node5 != null:
		actual_node5 = get_node(node5)
		actual_node_list.append(actual_node5)

func _process(delta):
	# Can change this into a signal in the Singleplayer class
	if Global.player_1_data.has(key_name):
		side = Global.LEFT
	elif Global.player_2_data.has(key_name):
		side = Global.RIGHT
	else:
		side = Global.NEUTRAL
	
	if can_press_again:
		_on_Timer_timeout()
	
	# Check to see if the key has been defeated
	if health < 1:
		emit_signal("defeated", key_name, player_last_attacked_by)
		_reset_stats()
	"""if(self.side != Global.NEUTRAL and can_attack):
		_attack()
		can_attack = false
		attack_delay.start()"""

func pressed(key):
	# Using self.name instead of key_name because of 
	# how keycodes are named in Godot
	# Ex: ; is returned as Semicolon
	if(key == self.name and can_press_again):
		_play_pressed_animation()
		if(self.side != Global.NEUTRAL and can_attack):
			_attack()
			can_attack = false
			attack_delay.start()
		can_press_again = false
		timer.start()

func _play_pressed_animation():
	match side:
		Global.NEUTRAL:
			animation_player.play("n_pressed")
		Global.LEFT:
			animation_player.play("l_pressed")
		Global.RIGHT:
			animation_player.play("r_pressed")
		_:
			print("There's a problem with the side variable!")

func _attack():
	for actual_node in actual_node_list:
		if(actual_node != null and actual_node.side != self.side):
			actual_node.health -= power
			actual_node.player_last_attacked_by = self.side

func _on_Timer_timeout():
	can_press_again = true
	match side:
		Global.NEUTRAL:
			animation_player.play("n_unpressed")
		Global.LEFT:
			animation_player.play("l_unpressed")
		Global.RIGHT:
			animation_player.play("r_unpressed")
		_:
			print("There's a problem with the side variable!")

func _on_AttackDelay_timeout():
	can_attack = true

func _reset_stats():
	health = 50
