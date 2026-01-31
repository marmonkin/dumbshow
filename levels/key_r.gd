extends Node2D

var playscene: PackedScene = load("res://levels/testilevel.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		get_tree().change_scene_to_packed(playscene)
