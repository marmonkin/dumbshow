extends Label

@onready var timer_label: Label = $"."

func _ready():
	var seconds = int(Global.survival_time)
	timer_label.text = "Survived: " + str(int(Global.survival_time)) + " seconds"
	Global.game_over = true
