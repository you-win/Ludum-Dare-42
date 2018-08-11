extends Node2D

# Signals
signal defeated

# Enums
enum { LEFT, NEUTRAL, RIGHT }

# Consts

# Vars
export var key_name = "Key" # Will be changed after being set in a scene
export var power = 100 # Strength of the current key

var side # Set by Player actor
var label

func _ready():
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
		emit_signal("defeated")
	