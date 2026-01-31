extends Node2D

@export var spawnspot: PackedScene = preload("res://objects/spawnspotter.tscn")

var spawn_positions = [
	Vector2(40, 120),
	Vector2(160, 40),
	Vector2(280, 120),
	Vector2(160, 200)
]

var spawn_index := 0
var spawning := false

func _process(_delta: float) -> void:
	var enemies_alive := get_tree().get_nodes_in_group("enemy").size()
	var spawnspots_alive := get_tree().get_nodes_in_group("spawnspot").size()

	# Start wave
	if enemies_alive == 0 and spawnspots_alive == 0 and not spawning:
		spawning = true
		spawn_index = 0

	# Spawn spots ONCE
	if spawning and spawn_index < spawn_positions.size():
		var s = spawnspot.instantiate()
		s.global_position = spawn_positions[spawn_index]
		get_tree().current_scene.add_child(s)
		spawn_index += 1

	# End wave when all spots created
	if spawn_index >= spawn_positions.size():
		spawning = false
