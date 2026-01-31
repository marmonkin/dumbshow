extends Node2D


@export var items : Array [Resource]

@onready var pickupable: PackedScene = preload("uid://1fjyk67lh6vh")

var amount = 0

func _on_timer_timeout() -> void:
	var item = pickupable.instantiate()
	item.item_data = items[randf_range(0, items.size())]
	add_child(item)
