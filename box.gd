extends RigidBody2D


@export var throw_force = 900.
@onready var timer: Timer = $Timer

var carried = false
var carrier: Node2D
var thrown = false


func pick_up(player: Node2D):
	carried = true
	carrier = player
	freeze = true
	linear_velocity = Vector2.ZERO
	angular_velocity = .0


func throw(direction: Vector2):
	carried = false
	carrier = null
	freeze = false
	thrown = true
	apply_impulse(direction.normalized() * throw_force)
	timer.start()


func _physics_process(_delta: float) -> void:
	if carried and carrier:
		global_position = carrier.global_position + Vector2(0, -1)


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		pick_up(body)


func _on_timer_timeout() -> void:
	thrown = false
