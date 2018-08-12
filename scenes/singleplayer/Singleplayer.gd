extends Node2D

# Signals
signal send_key_pressed
signal key_side_changed

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
	Global.player_2_data = ["["]

func update_score(key, new_owner):
	if new_owner == Global.LEFT:
		Global.player_1_data.append(key)
		if Global.player_2_data.has(key):
			Global.player_2_data.remove(key)
	elif new_owner == Global.RIGHT:
		Global.player_2_data.append(key)
		if Global.player_1_data.has(key):
			Global.player_1_data.remove(key)
	elif new_owner == Global.NEUTRAL:
		if Global.player_1_data.has(key):
			Global.player_1_data.remove(key)
		if Global.player_2_data.has(key):
			Global.player_2_data.remove(key)
	else:
		print("There's been a problem in the update_score function")
