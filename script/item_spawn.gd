extends Node2D


@export var items : Array [Resource]
@export var amount = 0
@export var spawn_range: Vector2 = Vector2(200, 200)

@onready var pickupable: PackedScene = preload("uid://dm1fmidfi4qky")


func _on_timer_timeout() -> void:
	if get_child_count() - 1 < amount:
		var item = pickupable.instantiate()
		item.item_data = items[randi() % items.size()]
		var offset = Vector2(
			randf_range(-spawn_range.x / 2, spawn_range.x / 2),
			randf_range(-spawn_range.y / 2, spawn_range.y / 2)
		)
		
		add_child(item)
		item.global_position = global_position + offset
