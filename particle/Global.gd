# Global.gd
extends Node

var survival_time: float = 0.0
var game_over: bool = false

func _process(delta: float) -> void:
	if not Global.game_over:
		Global.survival_time += delta
