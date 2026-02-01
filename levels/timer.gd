extends Node2D

@onready var timer_label: Label = $Label

var time_left: float = 0

func _ready() -> void:
	Global.game_over = false
	Global.survival_time = 0
	pass

func _process(delta: float) -> void:
	time_left += delta
	timer_label.text = str(int(time_left))
	Global.survival_time = time_left
