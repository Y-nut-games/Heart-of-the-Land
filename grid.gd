extends Node2D

var size_grid : int = Global.size_board.x
var tile_size = Global.tile_size
var starting_point
@onready var tile_map: TileMap = $TileMap

func _ready() -> void:
	starting_point = Vector2i(-size_grid*tile_size/2, -size_grid*tile_size/2)
	tile_map.position = starting_point
	
	for i in range(0, size_grid):
		for j in range(0, size_grid):
			tile_map.set_cell(0, Vector2i(i, j), 0, Vector2i(1, 3))

func get_attack_pattern():
	if get_parent().is_in_group("Enemy"):
		for i in get_parent().get_attacks():
			tile_map.set_cell(0, Vector2i(position+i*tile_size), 0, Vector2i(0, 3))
		
