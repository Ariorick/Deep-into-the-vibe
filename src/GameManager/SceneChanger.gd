extends Node2D

var default_scene = ""

func reload_scene():
	get_tree().change_scene("res://src/Main.tscn")

func _unhandled_input(event):
	if Input.is_action_just_pressed("restart"):
		reload_scene()
