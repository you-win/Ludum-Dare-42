extends Button

var select_sound

func _ready():
	select_sound = $SelectSound
	
	self.connect("pressed", self, "_play_select_sound")
	self.connect("pressed", Global, "change_state", [Global.SINGLEPLAYER])

func _play_select_sound():
	select_sound.play()