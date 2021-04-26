extends AudioStreamPlayer
class_name AudioAnalyzer

# 96.40
const INITIAL_PAUSE = 200

signal low_beat
signal middle_beat
signal high_beat
signal overall_db_updated
export(float) var bass_sensitivity: float = 1
export(float) var middle_sensitivity: float = 1
export(float) var high_sensitivity: float = 1

onready var spectrum = AudioServer.get_bus_effect_instance(1, 2)

var max_db = -0
var min_db = -40
var prev_beats := Dictionary()
var started := false

func _ready():
	max_db += volume_db
	min_db += volume_db
	

func _process(delta):
	if not started and OS.get_ticks_msec() > 100:
		playing = true
		started = true

func _on_Timer_timeout():
	analyse()

func analyse():
	print("-----------------")
#	   GENERATED SYNTHS 
	analyze_frequency(20, 100, 9.0 / bass_sensitivity, "BASS", "low_beat")
	analyze_frequency(2000, 8000, 2.5 / middle_sensitivity, "MIDD", "middle_beat")
	analyze_frequency(8000, 17000, 30.0 / high_sensitivity, "HIGH", "high_beat")
# 	   REMINDS ME OF SOMETHING
#	analyze_frequency(20, 100, 18.5 / bass_sensitivity, "BASS", "low_beat")
#	analyze_frequency(2000, 8000, 4.0 / middle_sensitivity, "MIDD", "middle_beat")
#	analyze_frequency(8000, 17000, 70.0 / high_sensitivity, "HIGH", "high_beat")

func analyze_frequency(start, end, treshold, tag, signal_name):
	var value = value_for_frequency(start, end)
	var prev_beat_time = -1000
	if prev_beats.has(tag):
		prev_beat_time = prev_beats[tag]
	
	print(tag, ": ", value)
	if value > treshold and OS.get_ticks_msec() - prev_beat_time > 311.2 * 4:
		prev_beats[tag] = OS.get_ticks_msec()
		emit_signal(signal_name)


func value_for_frequency(start, end) -> float:
	var mag = linear2db(spectrum.get_magnitude_for_frequency_range(start, end, 1).length())
	mag = (mag - min_db) / (max_db - min_db)
	return pow(mag * 7, 2)

func _on_MusicTimer_timeout():
	playing = false
