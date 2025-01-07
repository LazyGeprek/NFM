extends Node

var turn = 0
@onready var player_hand = Table.access.data.player_hand
@onready var cpu1_hand = Table.access.data.cpu1_hand
@onready var cpu2_hand = Table.access.data.cpu2_hand
@onready var cpu3_hand = Table.access.data.cpu3_hand

signal phand_changed
signal cpu1hand_changed
signal cpu2hand_drawed 
signal cpu3hand_drawed
signal turn_changed

func _ready():
	start_round()
	turns()
	turn_changed.connect(turns)

func start_round():
	make_wall()
	initial_deal()

func make_wall():
	Table.access.wall.initialize_wall()

func initial_deal():
	deal_tiles_to_hand(player_hand, phand_changed)
	deal_tiles_to_hand(cpu1_hand, cpu1hand_changed)

func deal_tiles_to_hand(hand, sig):
	while hand.size() < 7:
		var tile = Table.access.wall.tile_wall.pop_front()
		hand.append(tile)
		hand.sort()
	sig.emit()
	print(hand)

func turns():
	if turn == 0:
		draw_tile(player_hand, phand_changed)
	else:
		draw_tile(cpu1_hand, cpu1hand_changed)

func draw_tile(hand, sig):
	var tile = Table.access.wall.tile_wall.pop_front()
	hand.append(tile)
	hand.sort()
	sig.emit()
	print(hand)
