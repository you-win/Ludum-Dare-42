extends Node2D

# Enums

# States
enum { MENU, SINGLEPLAYER, MULTIPLAYER, PAUSE }

# Vars
var _state
var _tree

# Global vars
var player_1_data
var player_2_data

# Theoretically should be run when the game starts running
func _ready():
	_tree = get_tree()
	_state = MENU

func change_state(new_state):
	_state = new_state
	_change_scene()

func _change_scene():
	match _state:
		MENU:
			_tree.change_scene("res://scenes/Menu/Menu.tscn")
		SINGLEPLAYER:
			print("Not yet implemented")
		MULTIPLAYER:
			print("Not yet implemented")
		PAUSE:
			print("Not yet implemented")
		_: # Catch errors
			print("There's been an error!")
			_tree.change_scene("res://scenes/BaseScene.tscn")