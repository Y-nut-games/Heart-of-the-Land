extends Node2D

@onready var object_container: Node = $ObjectContainer
const ENEMY = preload("uid://c00cvk7oobeba")
const HEART = preload("uid://by8dx56mp3b1d")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if randf() > 0.95:
		var enemy = ENEMY.instantiate()
		enemy.position = global_position
		object_container.add_child(enemy)


func put_heart():
	if object_container.get_child_count() < 1:
		var heart = HEART.instantiate()
		heart.position = global_position
		object_container.add_child(heart)
	
