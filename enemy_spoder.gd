extends CharacterBody2D


@export var player : Node2D

@export var SPEED = 150.0
@export var MAX_ANGLE = 45.

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
