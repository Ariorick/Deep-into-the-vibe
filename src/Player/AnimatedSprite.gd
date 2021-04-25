extends AnimatedSprite3D

var speed = 1.2

func _process(delta):
	var count = frames.get_frame_count("run_up")
	frame = (int(OS.get_ticks_msec() * speed) / 100) % count
