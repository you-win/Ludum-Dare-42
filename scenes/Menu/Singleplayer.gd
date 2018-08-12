extends Button

func _ready():
	self.connect("pressed", Global, "change_state", [Global.SINGLEPLAYER])
