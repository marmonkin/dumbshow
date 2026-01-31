extends Node2D

@export var spawnspot: PackedScene = preload("res://objects/spawnspotter.tscn")

var maxspawnamount := 4
var spawnamount := 0
var spawn_positions = [
	Vector2(40, 120),
	Vector2(160, 40),
	Vector2(280, 120),
	Vector2(160, 200)
]
var spawn_cooldown := 0.0
var spawn_delay := 0.1

func _process(delta: float) -> void:
	spawn_cooldown -= delta

	var enemies_alive = get_tree().get_nodes_in_group("enemy").size()

	if (enemies_alive == 0) and (spawnamount < maxspawnamount) and (spawn_cooldown <= 0.0):
		var create = spawnspot.instantiate()
		create.global_position = spawn_positions[spawnamount]
		get_tree().current_scene.add_child(create)
		print(spawn_positions[spawnamount])
		spawnamount += 1
		spawn_cooldown = spawn_delay
