extends CharacterBody2D

@onready var playernode: CharacterBody2D = %player_guy

@onready var sprite: Sprite2D = $Sprite2D

var frame_index := 0
var frame_timer := 0.0
var frame_speed := 0.1

var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0
var max_speed: float = 400.0
var acceleration: float = 500.0
var friction: float = 200.0
var rotdir: float = 1

func _process(delta: float) -> void:
	frame_timer += delta
	if frame_timer >= frame_speed:
		frame_timer = 0
		frame_index = (frame_index + 1) % sprite.hframes  # loop through frames
		sprite.frame = frame_index

func _physics_process(delta: float) -> void:
	if playernode != null:
		rotation += .04 * rotdir;
		if knockback_timer > 0.0:
			velocity = knockback
			knockback_timer -= delta
		else:
			var dir = (playernode.global_position - global_position).normalized()
			velocity += dir * acceleration * delta
		
		velocity = velocity.limit_length(max_speed)
		
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
			
		move_and_slide()

func apply_knockback(direction: Vector2, force: float, duration: float) -> void:
	knockback = direction * force
	knockback_timer = duration
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("push"):
		
		$"../Camera2D".shake(2)
		Hitstop.freeze_frames(10)
		
	if body.is_in_group("wall"):
		var dir = (Vector2(160,120) - global_position).normalized()
		var playerdir = (playernode.global_position - global_position).normalized()
		var lerpdir = lerp(dir, playerdir, .5).normalized()
		#var distance = global_position.distance_to(playernode.global_position) #was player.globalpos
		apply_knockback(lerpdir, 100, .5)
	else:
		var dir = (global_position - body.global_position).normalized()
		var distance = global_position.distance_to(playernode.global_position) #was player.globalpos
		apply_knockback(dir, distance*4, .25)

	if body.has_method("die"):
		body.die()
	elif body.is_in_group("box"):
		body.queue_free()

	if rotdir == 1:
		rotdir = -1
	else:
		rotdir = 1
