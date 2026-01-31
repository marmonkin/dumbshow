extends CharacterBody2D


@export var SPEED = 150.0
@export var MAX_ANGLE = 45.

@onready var player: Node2D = get_tree().get_nodes_in_group("player")[0]

const CPU_PARTICLES_2D = preload("uid://dy7883pg6rnxb")

var move_direction := Vector2.ZERO
var move_timer := .3
var wait_timer := 0.0

func _physics_process(delta: float) -> void:
	if not player:
		return

	if move_timer > 0.0:
		# Move during burst
		move_timer -= delta
		velocity = move_direction * SPEED
		move_and_slide()
	else:
		# Stop and wait
		velocity = Vector2.ZERO
		wait_timer -= delta

		if wait_timer <= 0.0:
			start_move()
			
			
func start_move() -> void:
	var to_player := (player.global_position - global_position).normalized()

	var angle_offset := deg_to_rad(randf_range(-MAX_ANGLE, MAX_ANGLE))
	move_direction = to_player.rotated(angle_offset)

	move_timer = randf_range(.2, .5)
	wait_timer = randf_range(.8, 1.5)


func die() -> void:
	var blood = CPU_PARTICLES_2D.instantiate()
	blood.global_position = global_position
	
	get_tree().current_scene.add_child(blood)
	blood.emitting = true
	queue_free()
	
func stun():
	velocity = Vector2.ZERO
	wait_timer = randf_range(.8, 1.5)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("box"):
		stun()
		body.die()
