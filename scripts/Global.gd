extends Node2D

# Enums
enum { MENU, SINGLEPLAYER, MULTIPLAYER, PAUSE }
enum { LEFT, RIGHT, NEUTRAL }

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

# Theoretically should be run when the game starts running
func _ready():
	_tree = get_tree()
	_state = MENU
	
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