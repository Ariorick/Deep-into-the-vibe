extends Spatial
class_name Background

const SquareScene = preload("res://src/Square.tscn")
const YELLOW_CAP = 0.3
const GRAVE_CAP = -0.3
const GREEN_CAP = -0.6

var stopped := false

#func _process(delta):
#	add_square(Color.white)

func _ready():
	GameManager.connect("on_player_death", self, "on_player_death")

func on_player_death():
	stopped = true

func add_square(color: Color, with_spikes: bool = false):
	if stopped: 
		return
	var square: Square = SquareScene.instance()
	square.start_size = 30.0 / pow((OS.get_ticks_msec() + 1) / 1000.0, 0.1)
	square.color = color
	square.with_spikes = with_spikes
	add_child(square)

func _on_SquareSpawnTimer_timeout():
	add_square(rgb(255, 0, 0), true)

func _on_RegularPathTimer_timeout():
	add_square(rgb(255, 178, 230))

func _on_AudioAnalyzer_low_beat():
	add_square(rgb(215, 38, 56))

func _on_AudioAnalyzer_middle_beat():
	add_square(rgb(217, 114, 255))

func _on_AudioAnalyzer_high_beat():
	add_square(rgb(0, 175, 185))

func rgb(r: float, g: float, b: float) -> Color:
	return Color(r / 255.0, g / 255.0, b / 255.0)


func _on_MusicTimer_timeout():
	stopped = true
	GameManager.finished()
