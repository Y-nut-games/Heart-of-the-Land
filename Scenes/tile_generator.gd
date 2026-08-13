extends Node2D

const DIRECTIONS := {
	"up": Vector2i(-Global.tile_size, 0),
	"down": Vector2i(Global.tile_size, 0),
	"left": Vector2i(0, -Global.tile_size),
	"right": Vector2i(0, Global.tile_size)
}

var tile_positions : Array[Vector2i] = []

func spawn_tiles(start_point, size):
	get_children().clear()
	if check_neighbours(start_point, 0):
		spawn_tile(start_point, true, "heart")

func check_neighbours(point: Vector2i, live_neighbours: int):
	for dir in DIRECTIONS:
		if point+dir not in tile_positions:
			live_neighbours-=1
	
	if live_neighbours == 0:
		print("nope")
		return true
	return false

func spawn_tile(point, populated: bool, name: String):
	pass
