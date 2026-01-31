extends CharacterBody2D


const SPEED = 100.0

var carry = false

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if carry and event.is_action_pressed("throw"):
		throw_shit()

func throw_shit():
	pass
