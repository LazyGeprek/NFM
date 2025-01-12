extends Control

var cpu1_hand = Table.access.data.cpu1_hand
var tile_button = preload("res://scenes/table/tile/tile.tscn")

func _ready():
	TableHandler.turn_changed.connect(_play)
	TableHandler.cpu1hand_changed.connect(_render_hand)

func _render_hand():
	var cpu1_hand_encoded = Table.access.tile.tile_encode(cpu1_hand)
	var x =  $MarginContainer/VBoxContainer.get_children()
	for n in x:
		n.queue_free()
	for i in range(cpu1_hand_encoded.size()):
		var code = cpu1_hand_encoded[i]  # Encoded
		var hex_value = cpu1_hand[i]  # Hexadecimal 
		var tile = tile_button.instantiate()
		var tile_texture = tile.get_node("TextureRect")
		tile_texture.texture = load("res://assets/tile_side.png")
		tile.set_tile_name(hex_value, code)
		tile.disabled = true
		$MarginContainer/VBoxContainer.add_child(tile)

func _play():
	if TableHandler.turn == "cpu1":
		var a = cpu1_hand.pick_random()
		var i = cpu1_hand.find(a)
		var u = cpu1_hand.pop_at(i)
		Table.access.data.cpu1_pool.append(u)
		cpu1_hand.erase(a)
		TableHandler.turn = "cpu2"
		TableHandler.cpu1hand_changed.emit()
		TableHandler.turn_changed.emit()
		print("CPU1 Hand: ", Table.access.data.cpu1_hand)
		print("Turn: ", TableHandler.turn)
