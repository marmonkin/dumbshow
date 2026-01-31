extends CPUParticles2D

var fading = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	emitting = true

func _physics_process(delta: float) -> void:
	if fading:
		modulate.a -= .05
		if modulate.a < .1:
			queue_free()



func _on_timer_timeout() -> void:
	fading = true
