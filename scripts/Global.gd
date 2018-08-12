extends Node2D

# Enums
enum { MENU, SINGLEPLAYER, MULTIPLAYER, PAUSE }

# Vars
var _state
var _tree

# Global vars
var player_1_data
var player_2_data

var key_names_to_replace = [
	"Comma",
	"Period",
	"BraceLeft",
	"Semicolon",
	"Equal",
	"Minus"
]

# Dicts
var attack_groups

# Theoretically should be run when the game starts running
func _ready():
	_tree = get_tree()
	_state = MENU
	
	_set_attack_groups()
	_reset_scores()

func change_state(new_state):
	_state = new_state
	_change_scene()

func _change_scene():
	match _state:
		MENU:
			_tree.change_scene("res://scenes/menu/Menu.tscn")
		SINGLEPLAYER:
			_reset_scores()
			# Load the scene here
			_tree.change_scene("res://scenes/singleplayer/Singleplayer.tscn")
		MULTIPLAYER:
			_reset_scores()
			# Load the scene here
			print("Not yet implemented")
		PAUSE:
			print("Not yet implemented")
		_: # Catch errors
			print("There's been an error!")
			_tree.change_scene("res://scenes/BaseScene.tscn")

func _reset_scores():
	player_1_data = []
	player_2_data = []

func _set_attack_groups():
	attack_groups = {
		# Top number row
		"1": ["2", "Q"],
		"2": ["1", "W", "3"],
		"3": ["2", "E", "4"],
		"4": ["3", "R", "5"],
		"5": ["4", "T", "6"],
		"6": ["5", "Y", "7"],
		"7": ["6", "U", "8"],
		"8": ["7", "I", "9"],
		"9": ["8", "O", "0"],
		"0": ["9", "P", "-"],
		"-": ["0", "P", "="],
		"=": ["-", "["],
		# Q row
		"Q": ["1", "W", "A"],
		"W": [],
		"E": [],
		"R": [],
		"T": [],
		"Y": [],
		"U": [],
		"I": [],
		"O": [],
		"P": [],
		"[": ["P", "=", ";"]
	}
	pass