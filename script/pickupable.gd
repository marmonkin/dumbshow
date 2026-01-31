extends Area2D

@export var item_data: ThrowableItem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Sprite2D.texture = item_data.sprite


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if !body.carry:
			body.pickup_shit(item_data)
			get_parent().remove_child(self)
			queue_free()
