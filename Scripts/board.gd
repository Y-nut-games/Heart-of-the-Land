extends Node

@onready var tile_map: TileMap = $"../TileMap"
@onready var tile_container: Node2D = $TileContainer
@onready var border_rect: ColorRect = $ColorRect

const TILE = preload("uid://yacbplqe45qj")

var number_hearts : int = 2


var borders = Rect2(1,1,GameManager.size_board,GameManager.size_board)

func _ready() -> void:
	border_rect.size.x = GameManager.size_board * 64
	border_rect.size.y = GameManager.size_board * 64
	tile_map.clear()
	for child in tile_container.get_children():
		child.queue_free()
	set_tiles(generate_level())
	border_rect.position.x = GameManager.size_borders.position.x
	border_rect.position.y = GameManager.size_borders.position.y
	border_rect.size.x = GameManager.size_borders.size.x
	border_rect.size.x = GameManager.size_borders.size.y
	print(GameManager.size_borders)
	print(border_rect)
	for child in tile_container.get_children():
		if number_hearts > 0 and randi()%10 == 1:
			child.put_heart()
			number_hearts -= 1
		
	
	

func generate_level():
	var walker = Walker.new(Vector2(19, 11), borders)
	var map = walker.walk(GameManager.size_board * 10)
	
	for pos in map:
		tile_map.set_cell(0, pos, 0, Vector2(1, 1))
	return map

func set_tiles(map):
	var _map = tile_map.get_used_rect()
	print("Map: ",_map)
	for i in range(5):  #going through the map over and over again to check
		for x in range(_map.position.x, _map.end.x):
			for y in range(_map.position.y, _map.end.y):
				check_neighbours(Vector2i(x,y), 3)
		
		
	for pos in map:
		if tile_map.get_cell_atlas_coords(0,pos) == Vector2i(1, 1):
			var tile = TILE.instantiate()
			tile.position = tile_map.map_to_local(pos)
			tile_container.add_child(tile)
			
	tile_map.clear()

	
func check_neighbours(pos, full_tiles):
	if tile_map.get_cell_source_id(0, pos) != -1:
		return false
	
	var full_neighbours = 0
	var up_position :Vector2i = pos + Vector2i(0, -1)
	var down_position :Vector2i = pos + Vector2i(0, 1)
	var right_position :Vector2i = pos + Vector2i(1, 0)
	var left_position :Vector2i = pos + Vector2i(-1, 0)
	if tile_map.get_cell_source_id(0,pos) == -1:
		if tile_map.get_cell_source_id(0,up_position) == 0:
			full_neighbours += 1
		if tile_map.get_cell_source_id(0,right_position) == 0:
			full_neighbours += 1
		if tile_map.get_cell_source_id(0,down_position) == 0:
			full_neighbours += 1
		if tile_map.get_cell_source_id(0,left_position) == 0:
			full_neighbours += 1
		
		if full_neighbours>=full_tiles:
			tile_map.set_cell(0, pos, 0, Vector2(1, 1))
			var tile = TILE.instantiate()
			tile.position = tile_map.map_to_local(pos)
			tile_container.add_child(tile)
			print("Neighbour number ",tile_container.get_child_count())
			return true
		return false
	
