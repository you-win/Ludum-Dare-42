extends Node2D

# Signals
signal send_key_pressed

# Vars
var keys_controlled_list
var keys_in_scene

func _ready():
	_initialize_scores()

func _input(event):
	if event is InputEventKey and not event.is_echo():
		emit_signal("send_key_pressed", OS.get_scancode_string(event.scancode))

func _initialize_scores():
	Global.player_1_data = ["Q"]
	Global.player_1_data = ["["]

func update_score(side):
	
	pass