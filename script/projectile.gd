extends Area2D

var direction: Vector2
var item_data: ThrowableItem

func initialize(dir: Vector2, data: ThrowableItem):
	item_data = data
	$Sprite2D.texture = item_data.sprite
	direction = dir

func _physics_process(delta):
	position += direction * item_data.speed * delta

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# do shit here
	if body.has_method("take_damage"):
		body.take_damage()
	
	queue_free()
