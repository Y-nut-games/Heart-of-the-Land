extends Resource
class_name enemy_type


@export var health : int
@export var movement : int
@export var range_attacks : Array[Vector2i]
@export var special_effect : Array[String]

#Sprites
@export var idle_sprite : Texture2D
@export var moving_sprite : Texture2D
@export var attack_sprite : Texture2D
@export var dead_sprite : Texture2D

func starve():
	if Global.turn > Global.starve_turns:
		health -= 1
