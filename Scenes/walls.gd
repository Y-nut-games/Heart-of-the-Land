extends Node2D

@onready var tile_map: TileMap = $TileMap

var corner = Vector2i(3, 1) #top right
var side = Vector2i(2, 1) #up

var flip_h := TileSetAtlasSource.TRANSFORM_FLIP_H
var flip_v := TileSetAtlasSource.TRANSFORM_FLIP_V
var transpose := TileSetAtlasSource.TRANSFORM_TRANSPOSE

func _ready():
	build_walls(Global.size_board/2)


func build_walls(size : Vector2i):
	tile_map.clear()
	
	tile_map.set_cell(0, Vector2i(size.x-1, 0), 0, corner)
	tile_map.set_cell(0, Vector2i(size.x-1, size.y-1), 0, corner,transpose | flip_h)
	tile_map.set_cell(0, Vector2i(0, size.y-1), 0, corner, flip_h | flip_v)
	tile_map.set_cell(0, Vector2i(0, 0), 0, corner, flip_v | transpose)
	
	for i in range(1, size.x-1):  #top and bottom row
		tile_map.set_cell(0, Vector2i(i, 0), 0, side)
		tile_map.set_cell(0, Vector2i(i, size.y-1), 0, side, flip_h | flip_v)
	
	for i in range(1, size.y-1):
		tile_map.set_cell(0, Vector2i(size.x-1, i), 0, side, transpose | flip_h)
		tile_map.set_cell(0, Vector2i(0, i), 0, side, flip_v | transpose)
