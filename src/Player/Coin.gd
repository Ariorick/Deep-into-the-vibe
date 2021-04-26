extends Area
class_name Coin


func _on_Heart_body_exited(body):
	if body is Player:
		GameManager.player_picked_coin()
		$AnimationPlayer.play("picked")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name  == "picked":
		queue_free()
