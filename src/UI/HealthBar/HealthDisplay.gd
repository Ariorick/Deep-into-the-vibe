extends Control

var bar_white = preload("res://src/UI/HealthBar/barHorizontal_red.png")

onready var healthbar = $HealthBar

func _ready():
	healthbar.texture_progress = bar_white
	if get_parent() and get_parent().get("max_health"):
		healthbar.max_value = get_parent().max_health
	
#func _process(delta):
#	global_rotation = 0
	
func update_healthbar(value):
	var percent = value/healthbar.max_value
	healthbar.modulate = Color(1 - percent, 0, percent, 0.4)

	show()
	healthbar.value = value

func set_max_value(value: int):
	healthbar.max_value = value
