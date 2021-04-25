tool
extends Area

const SpikeScene = preload("res://src/Spike.tscn")

export var surface := Vector2(20, 20)

func _ready():
	$CollisionShape.shape.extents = Vector3(surface.x / 2, 5, surface.y / 2)
	$CollisionShape.translation = Vector3(surface.x / 2, 5, surface.y / 2)
	for i in range(0, surface.x, 10):
		for j in range (0, surface.y, 10):
			var spike = SpikeScene.instance()
			add_child(spike)
			spike.translation = Vector3(i + 5, 0, j)
			


func _on_Spikes_body_entered(body):
	GameManager.player_take_damage()
	var origin = transform.origin
	CameraManager.player_hit_shake(Vector2(origin.x, origin.y))
