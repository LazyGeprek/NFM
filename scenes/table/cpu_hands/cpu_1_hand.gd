extends Control

var cpu1_hand = Table.access.data.cpu1_hand
var tile_button = preload("res://scenes/table/tile/tile.tscn")

func _ready():
	_render_hand()

func _render_hand():
	var cpu1_hand_encoded = Table.access.tile.tile_encode(cpu1_hand)
	for i in range(cpu1_hand_encoded.size()):
		var code = cpu1_hand_encoded[i]  # Encoded
		var hex_value = cpu1_hand[i]  # Hexadecimal 
		
		var tile = tile_button.instantiate()
		var tile_texture = tile.get_node("TextureRect")
		tile_texture.texture = load("res://assets/tile_side.png")
		tile.set_tile_name(hex_value, code)
		tile.disabled = true
		$MarginContainer/VBoxContainer.add_child(tile)
