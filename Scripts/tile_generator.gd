extends Node2D

const DIRECTIONS := {
	"up": Vector2i.UP,
	"down": Vector2i.DOWN,
	"left": Vector2i.LEFT,
	"right": Vector2i.RIGHT
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
