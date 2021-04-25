extends KinematicBody
class_name Player

const PLAYER_CENTER = Vector2(0, -8)
const WALK_FORCE = 70
const JUMP_FORCE = 210
const GRAVITY_FORCE = 10.0

const RADIUS = 40

var in_air = true
var is_invinsible = false
var input_unavailable_until := -10000

func _ready():
	translation = Vector3(0, 0, 100)
	GameManager.player = self
	move_to(Vector3(0, -1, 0) * RADIUS)


func move_to(pos: Vector3):
	var new_rotation = get_rotation_for(Vector2(pos.x, pos.y))
	$Tween.interpolate_property(self, "translation", translation, pos, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.interpolate_property(self, "rotation", rotation, new_rotation, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.start()
	in_air = true

func get_rotation_for(direction: Vector2) -> Vector3:
	if direction.y >= 0.707:
		return Vector3(0, 0, PI)
	elif direction.y <= -0.707:
		return Vector3(0, 0, 0)
	elif direction.x <= -0.707:
		return Vector3(0, 0, -PI/2)
	elif direction.x >= 0.707:
		return Vector3(0, 0, PI/2)
	return Vector3(0, 0, 0)

func _physics_process(delta):
	if not in_air:
		var direction = PlayerInput.get_direction().normalized()
		var desired_place = Vector3(direction.x, direction.y, 0) * RADIUS
		if desired_place != Vector3.ZERO and translation != desired_place:
			move_to(desired_place)

func _on_Tween_tween_all_completed():
	in_air = false

func take_directional_damage(direction: Vector2):
	CameraManager.player_hit_shake(direction)
	take_damage()

func take_damage():
	GameManager.player_take_damage()
	$ColorAnimationPlayer.play("PlayerTakeDamage")

func die():
	set_physics_process(false)
	move_to(Vector3(0, 0, 50))

func select_animation(move_direction: Vector2):
	move_direction = move_direction.normalized()
	if move_direction != Vector2.ZERO:
		$AnimatedSprite.play("run_" + get_direction_name(move_direction))


func get_direction_name(direction: Vector2) -> String:
	if direction.y >= 0.707:
		return "down"
	elif direction.y <= -0.707:
		return "up"
	elif direction.x <= -0.707:
		return "left"
	elif direction.x >= 0.707:
		return "right"
	return "down"

