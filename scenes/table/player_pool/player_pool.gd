extends Control

var player_pool = Table.access.data.player_pool
var tile_button = preload("res://scenes/table/tile/tile.tscn")
@onready var grid = $MarginContainer/GridContainer

func _ready():
	TableHandler.phand_discarded.connect(_render_player_pool)

func _render_player_pool():
	for child in grid.get_children():
		child.queue_free()
	
	var player_pool_encoded = Table.access.tile.tile_encode(player_pool)
	for i in range(player_pool_encoded.size()):
		var code = player_pool_encoded[i]  # Encoded
		var hex_value = player_pool[i]  # Hexadecimal 
		
		var tile = tile_button.instantiate()
		var tile_texture = tile.get_node("TextureRect")
		tile_texture.texture = load("res://assets/tiles/%s.png" %code)
		tile.set_tile_name(hex_value, code)
		tile.disabled = true
		grid.add_child(tile)
