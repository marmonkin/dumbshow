extends Node2D

var direction: Vector2
var item_data: ThrowableItem

const BOX_SPLINT = preload("uid://cxpn0u7oiyako")

func initialize(dir: Vector2, data: ThrowableItem):
	item_data = data
	$Sprite2D.texture = item_data.sprite
	direction = dir

func _physics_process(delta):
	position += direction * item_data.speed * delta
	$Sprite2D.rotation += TAU * 5. * delta

func _ready():
	pass
	#body_entered.connect(_on_body_entered)

func die() -> void:
	var audio = %boxbreak
	remove_child(audio)
	get_tree().current_scene.add_child(audio)

	audio.global_position = global_position
	audio.play()

	audio.finished.connect(audio.queue_free)
	
	var splint = BOX_SPLINT.instantiate()
	splint.global_position = global_position
	get_tree().current_scene.add_child(splint)
	splint.emitting = true
	
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()


func _on_projectile_body_entered(body: Node2D) -> void:
	if body.is_in_group("wall"):
		die()
