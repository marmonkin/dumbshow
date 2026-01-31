extends Node2D

@onready var bg = $TextureRect

var start_pos: Vector2
var speed := 0.5  # pixels per second

func _ready():
	start_pos = bg.position  # store the original position

func _process(delta):
	# move left
	bg.position.x += speed
	bg.position.y += speed/2

	# reset if moved 64 pixels left
	if bg.position.x >= start_pos.x + 64:
		bg.position.x = start_pos.x
		
	if bg.position.y >= start_pos.y + 64:
		bg.position.y = start_pos.y
