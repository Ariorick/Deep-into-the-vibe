extends Area



func _on_Heart_body_exited(body):
	if body is Player:
		GameManager.player_pick_health()
		$AnimationPlayer.play("picked")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name  == "picked":
		queue_free()
