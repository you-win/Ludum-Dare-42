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

var key_name
var label

var side
var player_last_attacked_by

func _ready():
	key_name = self.name
	label = $Label
	side = NEUTRAL
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
	if key == key_name:
		print("HELP")

func _attack():
	
	pass
