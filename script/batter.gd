extends CharacterBody2D

@export var SPEED = 50.0

@onready var player := get_tree().get_first_node_in_group("player") as Node2D

const CPU_PARTICLES_2D = preload("uid://dy7883pg6rnxb")

@onready var sprite: Sprite2D = $Sprite2D

var move_direction := Vector2.ZERO
var wait_timer := 0.0

var frame_index := 0
var frame_timer := 0.0
var frame_speed := 0.1

func _ready():
	randomize()

func _process(delta: float) -> void:
	if velocity != Vector2.ZERO:
		frame_timer += delta
		if frame_timer >= frame_speed:
			frame_timer = 0
			frame_index = (frame_index + 1) % sprite.hframes 
			sprite.frame = frame_index

func _physics_process(delta: float) -> void:
	if not player:
		return
		
	if wait_timer <= 0.0:
		start_move()
		
	else:
		wait_timer -= delta
		position -= velocity * delta
	velocity = move_direction * SPEED
	move_and_slide()

func start_move() -> void:
	var to_player = (player.global_position - global_position).normalized()
	move_direction = to_player


func die() -> void:
	var blood = CPU_PARTICLES_2D.instantiate()
	blood.global_position = global_position
	
	get_tree().current_scene.add_child(blood)
	blood.emitting = true
	queue_free()
	
func stun():
	velocity = Vector2.ZERO
	wait_timer = randf_range(1.5, 2.)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("box"):
		stun()
		body.die()
