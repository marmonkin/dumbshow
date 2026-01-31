extends Node2D


@export var items : Array [Resource]
@export var amount = 0

@onready var pickupable: PackedScene = preload("uid://1fjyk67lh6vh")
@onready var shape = $Area2D/CollisionShape2D.shape as RectangleShape2D


func _on_timer_timeout() -> void:
	if get_child_count() - 1 < amount:
		var item = pickupable.instantiate()
		item.global_position = get_random_point()
		item.item_data = items[randf_range(0, items.size())]
		add_child(item)

func get_random_point() -> Vector2:
	var extent = shape.extents
	var local_point = Vector2(randf_range(-extent.x, extent.x),randf_range(-extent.y, extent.y))
	return to_global(local_point)
