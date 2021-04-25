extends Spatial

const PlayerScene = preload("res://src/Player/Player.tscn")



func _on_SpawnPlayerTimer_timeout():
	add_child(PlayerScene.instance())
	$Background/SpikeSpawnTimer.start()
