extends Sprite2D

#get enemytype from creator

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate.a = 0.0
	scale = Vector2.ONE
	
	var tween = create_tween()
	
	tween.tween_property(self,"modulate:a",1.0,1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(self,"scale",Vector2.ONE,1.0).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	
	$spawnanim.play("spawnanim")
	await get_tree().create_timer(1).timeout
	print("ENEMY")
	#do something


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation_degrees += 5
	pass
