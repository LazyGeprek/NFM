class_name Table
extends Node

static var access: Table
var data: TableData
var wall: MahjongWall
var tile: MahjongTile

func _init() -> void:
	data = TableData.new()
	wall = MahjongWall.new()
	tile = MahjongTile.new()
	_execute_singleton()

func _execute_singleton() -> void:
	if not access:
		access = self
	else:
		queue_free()
