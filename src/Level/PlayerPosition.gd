extends Node2D
class_name PlayerPosition


func _process(delta):
	var pos = GameManager.player_position
	global_position = Vector2(int(pos.x), int(pos.y))
