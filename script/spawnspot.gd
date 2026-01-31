extends Node2D

var ENEMY_SPODER = preload("uid://braiij1uykq53")

func _ready() -> void:
	modulate.a = 0.0
	scale = Vector2.ZERO
	add_to_group("spawnspot")
	
	var tween = create_tween()

	tween.tween_property(self, "modulate:a", 1.0, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2.ONE, 2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	await get_tree().create_timer(1).timeout
	
	#SPAWN ENEMY
	var enemy_instance = ENEMY_SPODER.instantiate()
	enemy_instance.global_position = global_position
	get_tree().current_scene.add_child(enemy_instance)
	
	await get_tree().create_timer(0.5).timeout
	queue_free()

func _process(delta: float) -> void:
	rotation_degrees += 5
	pass
