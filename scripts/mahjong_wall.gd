class_name MahjongWall
extends MahjongTile

var tile_wall = []

func initialize_wall():
	add_tiles()
	shuffle_tiles()

func add_tiles():
	tile_wall = tiles.duplicate()

func shuffle_tiles():
	# Fisher-Yates shuffle
	var n = tile_wall.size()
	for i in range(n - 1, 0, -1):
		var j = randi() % (i + 1)
		var temp = tile_wall[i]
		tile_wall[i] = tile_wall[j]
		tile_wall[j] = temp

func new_tile_wall():
	tile_wall.clear()
	initialize_wall()
