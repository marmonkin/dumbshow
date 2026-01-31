extends Area2D

@export var item_data: ThrowableItem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.pick_up(item_data)
		queue_free()
