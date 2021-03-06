extends Node

signal player_health_changed
signal player_health_decreaced
signal on_player_death
signal coins_changed
signal finished

const SPEED := 1.0

const MAX_HEALTH := 5
var health := MAX_HEALTH
var coins := 0

var player
var player_position: Vector2

func player_take_damage():
	health -= 1
	print("Player health is ", health, "/", MAX_HEALTH)
	emit_signal("player_health_changed")
	emit_signal("player_health_decreaced")
	if health == 0:
		emit_signal("on_player_death")
		player.die()


func health_is_not_max():
	return health < MAX_HEALTH

func player_pick_health():
	health += 1
	health = min(health, MAX_HEALTH)
	emit_signal("player_health_changed")

func player_picked_coin():
	coins += 1
	emit_signal("coins_changed")

func get_health_percent():
	return 1.0 * health / MAX_HEALTH

func finished():
	player.die()
	emit_signal("on_player_death")
	emit_signal("finished")

func reset():
	health = MAX_HEALTH
	coins = 0
	
