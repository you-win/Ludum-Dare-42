extends Button

var select_sound

func _ready():
	select_sound = $SelectSound
	
	self.connect("pressed", self, "_play_select_sound")
	self.connect("pressed", self, "_exit_game")

func _exit_game():
	get_tree().quit()

func _play_select_sound():
	select_sound.play()