extends CharacterBody2D


@onready var throw_origin: Marker2D = $Marker2D

const SPEED = 100.0

var carry = false
var held_item: ThrowableItem = null

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if carry and event.is_action_pressed("throw"):
		throw_shit()

func pickup_shit(item: ThrowableItem):
	held_item = item
	carry = true

func throw_shit():
	var projectile = held_item.projectile_scene.instantiate()
	projectile.global_position = throw_origin.global_position
	projectile.initialize((get_global_mouse_position() - global_position).normalized(),held_item)
	get_tree().current_scene.add_child(projectile)
	held_item = null
	carry = false
	
