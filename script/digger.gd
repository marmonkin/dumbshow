extends CharacterBody2D

enum MoleState {
	SURFACED,
	WAITING,
	DIGGING,
	HIDDEN,
	EMERGING,
}

@export var spawn_range: Vector2 = Vector2(200, 200)

@onready var player: Node2D = get_tree().get_nodes_in_group("player")[0]
@onready var collider: CollisionShape2D = $CollisionShape2D
@onready var area: CollisionShape2D = $Area2D/CollisionShape2D
@onready var timer: Timer = $Timer

@onready var animation = $AnimationPlayer

const CPU_PARTICLES_2D = preload("uid://dy7883pg6rnxb")

var wait_timer := 0.0
var state: MoleState = MoleState.SURFACED


func _physics_process(delta: float) -> void:
	if not player:
		return
	

func relocate():
	var offset = Vector2(
		randf_range(-spawn_range.x / 2, spawn_range.x / 2),
		randf_range(-spawn_range.y / 2, spawn_range.y / 2)
	)
	global_position = offset

func set_state(new_state: MoleState):
	state = new_state
	
	match state:
		MoleState.SURFACED:
			animation.play("surface")
			collider.disabled = false
			area.disabled = false
			timer.start(2.)
		
		MoleState.DIGGING:
			animation.play("down")
			collider.disabled = true
			area.disabled = true
			# dig animation
			timer.start(.8)
		
		MoleState.HIDDEN:
			relocate()
			timer.start(1.5)
		
		MoleState.EMERGING:
			# emerge animation
			animation.play("up")
			timer.start(.8)

func die() -> void:
	var blood = CPU_PARTICLES_2D.instantiate()
	blood.global_position = global_position
	
	get_tree().current_scene.add_child(blood)
	blood.emitting = true
	queue_free()
	
func stun():
	timer.start(randf_range(2., 2.5))


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("box"):
		stun()
		body.die()


func _on_timer_timeout() -> void:
	match state:
		MoleState.SURFACED:
			set_state(MoleState.DIGGING)

		MoleState.DIGGING:
			set_state(MoleState.HIDDEN)

		MoleState.HIDDEN:
			set_state(MoleState.EMERGING)

		MoleState.EMERGING:
			set_state(MoleState.SURFACED)
