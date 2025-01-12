extends Control

var cpu2_hand = Table.access.data.cpu2_hand
var tile_button = preload("res://scenes/table/tile/tile.tscn")

func _ready():
	TableHandler.turn_changed.connect(_play)
	TableHandler.cpu2hand_changed.connect(_render_hand)

func _render_hand():
	var cpu2_hand_encoded = Table.access.tile.tile_encode(cpu2_hand)
	var x =  $MarginContainer/HBoxContainer.get_children()
	for n in x:
		n.queue_free()
	for i in range(cpu2_hand_encoded.size()):
		var code = cpu2_hand_encoded[i]  # Encoded
		var hex_value = cpu2_hand[i]  # Hexadecimal 
		var tile = tile_button.instantiate()
		var tile_texture = tile.get_node("TextureRect")
		tile_texture.texture = load("res://assets/tiles/%s.png" %code)
		tile.set_tile_name(hex_value, code)
		tile.disabled = true
		$MarginContainer/HBoxContainer.add_child(tile)

func _play():
	if TableHandler.turn == "cpu2":
		var a = cpu2_hand.pick_random()
		var i = cpu2_hand.find(a)
		var u = cpu2_hand.pop_at(i)
		Table.access.data.cpu2_pool.append(u)
		cpu2_hand.erase(a)
		TableHandler.turn = "player"
		TableHandler.cpu2hand_changed.emit()
		TableHandler.turn_changed.emit()
		print("CPU2 Hand: ", Table.access.data.cpu2_hand)
		print("Turn: ", TableHandler.turn)
