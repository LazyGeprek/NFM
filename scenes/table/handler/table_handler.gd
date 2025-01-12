extends Node

var turn = "player"
@onready var player_hand = Table.access.data.player_hand
@onready var cpu1_hand = Table.access.data.cpu1_hand
@onready var cpu2_hand = Table.access.data.cpu2_hand
@onready var cpu3_hand = Table.access.data.cpu3_hand

signal phand_changed
signal cpu1hand_changed
signal cpu2hand_changed
signal turn_changed

func _ready():
	turn_changed.connect(turns)

func start_round():
	make_wall()
	initial_deal()
	turns()

func make_wall():
	Table.access.wall.initialize_wall()

func initial_deal():
	deal_tiles_to_hand(player_hand, phand_changed)
	deal_tiles_to_hand(cpu1_hand, cpu1hand_changed)
	deal_tiles_to_hand(cpu2_hand, cpu2hand_changed)

func deal_tiles_to_hand(hand, sig):
	while hand.size() < 7:
		var tile = Table.access.wall.tile_wall.pop_front()
		hand.append(tile)
		hand.sort()
		sig.emit()

func turns():
	if turn == "player":
		draw_tile(player_hand, phand_changed)
	if turn == "cpu1":
		draw_tile(cpu1_hand, cpu1hand_changed)
	if turn == "cpu2":
		draw_tile(cpu2_hand, cpu2hand_changed)

func draw_tile(hand, sig):
	if hand.size() < 8:
		var tile = Table.access.wall.tile_wall.pop_front()
		hand.append(tile)
		hand.sort()
		sig.emit()
		print(tile, " drawn by ", hand)
