extends Node2D

@export var enemy_to_spawn : PackedScene
@export var amount = 0

@onready var player_guy: CharacterBody2D = $"../player_guy"


func _on_timer_timeout() -> void:
	if amount <= 0:
		$Timer.stop()
		pass
	amount -= 1
	var enemy = enemy_to_spawn.instantiate()
	add_child(enemy)
	enemy.player = player_guy
