extends Button

func _ready():
	self.pressed.connect(_pressed)
	
func _pressed():
	TableHandler.start_round()
	self.disabled
	self.visible = false
