extends Button

func _ready():
	self.connect("pressed", self, "_exit_game")

func _exit_game():
	get_tree().quit()