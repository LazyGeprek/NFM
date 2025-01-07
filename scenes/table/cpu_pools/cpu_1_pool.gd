extends Control

var cpu1_pool = Table.access.data.cpu1_pool
var tile_button = preload("res://scenes/table/tile/tile.tscn")
@onready var grid = $MarginContainer/GridContainer

func _ready():
	TableHandler.cpu1hand_changed.connect(_render_cpu1_pool)

func _render_cpu1_pool():
	for child in grid.get_children():
		child.queue_free()
	
	var cpu1_pool_encoded = Table.access.tile.tile_encode(cpu1_pool)
	for i in range(cpu1_pool_encoded.size()):
		var code = cpu1_pool_encoded[i]  # Encoded
		var hex_value = cpu1_pool[i]  # Hexadecimal 
		
		var tile = tile_button.instantiate()
		var tile_texture = tile.get_node("TextureRect")
		tile_texture.texture = load("res://assets/tiles/%s.png" %code)
		tile.set_tile_name(hex_value, code)
		tile.disabled = true
		grid.add_child(tile)
