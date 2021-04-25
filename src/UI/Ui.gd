extends CanvasLayer


func _ready():
	$HealthDisplay.set_max_value(GameManager.MAX_HEALTH)
	GameManager.connect("player_health_changed", self, "player_health_changed")
	GameManager.connect("arrow_count_changed", self, "arrow_count_changed")
	GameManager.connect("damage_changed", self, "damage_changed")
	GameManager.connect("kill_count_changed", self, "kill_count_changed")
	GameManager.connect("on_player_death", self, "on_player_death")
	update()

func update():
	player_health_changed()


func player_health_changed():
	$HealthDisplay.update_healthbar(GameManager.health)
	$AnimationPlayer.play("hit")


func on_player_death():
	$AnimationPlayer.play("show_restart")
