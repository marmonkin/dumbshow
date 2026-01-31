extends Camera2D

var shake_amount := 0.0
var shake_decay := 5.0
var orgpos := Vector2.ZERO

func _ready() -> void:
	orgpos = position

func _process(delta: float) -> void:
	if shake_amount > 0:
		position = orgpos + Vector2(
			randf_range(-shake_amount,shake_amount),
			randf_range(-shake_amount,shake_amount),
		)
		shake_amount = max(shake_amount - shake_decay * delta, 0)
	else:
		position = orgpos

func shake(intensity: float):
	shake_amount = intensity
