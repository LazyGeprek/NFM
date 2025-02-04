extends Button

var tile_name = null
var tile_name_encoded = null

func set_tile_name(x, y):
	tile_name = x
	tile_name_encoded = y

func _ready():
	self.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	Table.access.data.player_hand.erase(tile_name)
	Table.access.data.player_pool.append(tile_name)
	TableHandler.phand_changed.emit()
	TableHandler.turn = "cpu1" 
	TableHandler.turn_changed.emit()
	print(tile_name, " a.k.a ", tile_name_encoded, " discarded")
	print("Player hand: ", Table.access.data.player_hand)
	print("Turn: ", TableHandler.turn)
	queue_free()
