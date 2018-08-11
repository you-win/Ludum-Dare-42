extends Node2D

var state

func _ready():
	pass

# Basic state machine
# Might not even be needed
func change_state(new_state):
	state = new_state

# Set starting key. Takes a side, left or right, and sets the starting
# key to be either Q or [
func initialize_starting_key(side):
	pass