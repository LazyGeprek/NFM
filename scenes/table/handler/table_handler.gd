extends Node

var current_turn = null
@onready var player_hand = Table.access.data.player_hand
@onready var cpu1_hand = Table.access.data.cpu1_hand
@onready var cpu2_hand = Table.access.data.cpu2_hand
@onready var cpu3_hand = Table.access.data.cpu3_hand

signal phand_drawed
signal cpu1hand_drawed 
signal cpu2hand_drawed 
signal cpu3hand_drawed
signal phand_discarded

func _ready():
	randomize()
	start_round()

func start_round():
	make_wall()
	initial_deal()
	current_turn = 0 #randi() % 4 
	start_turn()

func make_wall():
	Table.access.wall.initialize_wall()

func deal_tiles_to_hand(hand, sig):
	while hand.size() < 8:
		var tile = Table.access.wall.tile_wall.pop_front()
		hand.append(tile)
		hand.sort()
	sig.emit()
	print(hand)

func initial_deal():
	deal_tiles_to_hand(player_hand, phand_drawed)
	deal_tiles_to_hand(cpu1_hand, cpu1hand_drawed)
	deal_tiles_to_hand(cpu2_hand, cpu2hand_drawed)
	deal_tiles_to_hand(cpu3_hand, cpu3hand_drawed)

func draw_tile(hand, sig):
	var tile = Table.access.wall.tile_wall.pop_front()
	hand.append(tile)
	hand.sort()
	sig.emit()
	print(hand)

func start_turn():
	if current_turn == 0:
		draw_tile(player_hand, phand_drawed)
	if current_turn == 1:
		draw_tile(cpu1_hand, cpu1hand_drawed)
	if current_turn == 2:
		draw_tile(cpu2_hand, cpu2hand_drawed)
	if current_turn == 3:
		draw_tile(cpu3_hand, cpu3hand_drawed)
