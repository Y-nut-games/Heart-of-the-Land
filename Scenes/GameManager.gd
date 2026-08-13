extends Node2D

const Tile = preload("uid://cxgwyisufyxur")
const WALLS = preload("uid://currdki8d4ycv")

@onready var tile_generator: Node2D = $tileGenerator

var wall_position := Vector2i(260, 100)
var heart_position

func _ready() -> void:
	set_game(Vector2(20, 20), 5)


func set_game(size_board, num_enemies):
	Global.size_board = size_board
	Global.size_enemies = num_enemies
	var wall = WALLS.instantiate()
	wall.position = wall_position
	add_child(wall)
	
	var offset = Vector2i(size_board.x*Global.tile_size/2, size_board.y*Global.tile_size/2)
	heart_position = wall_position + offset
	
	tileGenerator.spawn_tiles(heart_position, size_board)
