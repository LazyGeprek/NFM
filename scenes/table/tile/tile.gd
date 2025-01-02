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
	TableHandler.phand_discarded.emit()
	print(tile_name, " a.k.a ", tile_name_encoded, " discarded")
	print(Table.access.data.player_hand)
	queue_free()
