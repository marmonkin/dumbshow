extends Node2D

var maxspawnamount := 4
var spawnamount := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (spawnamount < maxspawnamount):
		await get_tree().create_timer(1).timeout
		
		spawnamount += 1
