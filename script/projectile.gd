extends Node2D

var direction: Vector2
var item_data: ThrowableItem

func initialize(dir: Vector2, data: ThrowableItem):
	item_data = data
	$Sprite2D.texture = item_data.sprite
	direction = dir

func _physics_process(delta):
	position += direction * item_data.speed * delta

func _ready():
	pass
	#body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# do shit here
	if !body.is_in_group("mask"):
		queue_free()


func _on_timer_timeout() -> void:
	queue_free()
