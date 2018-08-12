extends Node2D

var _parent
var _children

func _ready():
	_parent = get_parent()
	_children = get_children()
	for key in _children:
		_parent.connect("send_key_pressed", key, "pressed")
		key.connect("defeated", _parent, "update_score")