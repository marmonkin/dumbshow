extends Node2D


@export var items : Array [Resource]
@export var amount = 0

@onready var pickupable: PackedScene = preload("uid://dm1fmidfi4qky")


func _on_timer_timeout() -> void:
	if get_child_count() - 1 < amount:
		var item = pickupable.instantiate()
		item.global_position = Vector2i(randi_range(80, 400), randi_range(40, 600)) 
		item.item_data = items[randi() % items.size()]
		add_child(item)
