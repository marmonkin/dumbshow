extends Area2D

var direction: Vector2
var item_data: ThrowableItem

func initialize(dir: Vector2, data: ThrowableItem):
	direction = dir
	item_data = data

func _physics_process(delta):
	position += direction * item_data.speed * delta

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# do shit here
	queue_free()
