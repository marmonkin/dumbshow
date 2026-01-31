extends Node2D

func freeze_frames(frames: int = 1) -> void:
	for i in range(frames):
		# Stop gameplay logic
		Engine.time_scale = 0.0
		# Wait one rendered frame
		await get_tree().process_frame
		# Resume normal time
		Engine.time_scale = 1.0
