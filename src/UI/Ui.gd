extends CanvasLayer



func _ready():
	$HealthDisplay.set_max_value(GameManager.MAX_HEALTH)
	GameManager.connect("player_health_changed", self, "player_health_changed")
	GameManager.connect("player_health_decreaced", self, "player_health_decreaced")
	GameManager.connect("on_player_death", self, "on_player_death")
	GameManager.connect("coins_changed", self, "coins_changed")
	GameManager.connect("finished", self, "finished")
	update()

func update():
	player_health_changed()


func player_health_changed():
	$HealthDisplay.update_healthbar(GameManager.health)

func coins_changed():
	$Coins.text = str(GameManager.coins * 1000)

func player_health_decreaced():
	$AnimationPlayer.play("hit")

func on_player_death():
	$AnimationPlayer.play("show_restart")

func finished():
	$Thanks.text = "THANKS FOR PLAYING!" + "\nYOUR SCORE IS " + str(GameManager.coins * 1000) + "\nrate the game and share your score \nin the comments"
	$FinishingAnimationPlayer.play("show_thanks")
