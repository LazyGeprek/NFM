extends Control

var player_hand = Table.access.data.player_hand
var tile_button = preload("res://scenes/table/tile/tile.tscn")

func _ready():
	_render_hand()

func _render_hand():
	var player_hand_encoded = Table.access.tile.tile_encode(player_hand)
	for i in range(player_hand_encoded.size()):
		var code = player_hand_encoded[i]  # Encoded
		var hex_value = player_hand[i]  # Hexadecimal 
		
		var tile = tile_button.instantiate()
		var tile_texture = tile.get_node("TextureRect")
		tile_texture.texture = load("res://assets/tiles/%s.png" %code)
		tile.set_tile_name(hex_value, code)
		$MarginContainer/HBoxContainer.add_child(tile)
