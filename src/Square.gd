extends Spatial
class_name Square

const SpikesScene = preload("res://src/Spikes.tscn")
const HeartScene = preload("res://src/Player/Heart.tscn")
const ROTATION_DISTANCE = 30.0

const WIDTH = 50
const DEPTH = 50
const RADIUS = 50

var with_heart := false
var with_spikes := false
var color: Color
var start_size := 0.0
var current_size := 0.0
var width := 0.0

var start_time = 0.0
var spikes_on = -1

func _ready():
	start_time = OS.get_ticks_msec()
	if with_spikes:
		spawn_spikes()
	spawn_heart()
	$Timer.wait_time = 4
	$Timer.start()
	current_size = start_size
	set_width(WIDTH)


func _process(delta):
	current_size += 0.1 + current_size / 100
	translation += Vector3(0, 0, 1)
	
	
#	scale = Vector3.ONE * current_size / 100

	rotation = Vector3(0, 0, min((current_size - start_size) / ROTATION_DISTANCE, PI/2))
	var scale_coef = max((current_size - start_size) / ROTATION_DISTANCE / 10, 1)
	var scale = Vector3.ONE * scale_coef

	var coef := 1.0 / current_size * start_size + 0.01
	var alpha = (1 - coef) / 2
#	if (translation + global_transform.origin) == Vector3.ZERO:
#		alpha = 1
	set_modulate(change_alpha(color, alpha))

func change_alpha(color: Color, a: float) -> Color:
	return Color(color.r, color.g, color.b, a)

func set_modulate(color: Color):
	for child in get_children():
		if child is StaticBody:
			child.get_node("MeshInstance").get_surface_material(0).albedo_color = color

func set_width(width: float):
	for child in get_children():
		if child is StaticBody:
			var size = child.get_node("MeshInstance").mesh.size
			child.get_node("MeshInstance").mesh.size = Vector3(width, size.y, DEPTH)
#			child.get_node("CollisionShape").shape.extents = Vector3(width/2, size.y, DEPTH/2)

func spawn_spikes():
	spikes_on = Random.i_range(1, 4)
	$SpikeContainer.rotation = Vector3(0, 0, PI/2 * spikes_on)
	var spikes = SpikesScene.instance()
	spikes.surface = Vector2(WIDTH, DEPTH)
	$SpikeContainer.add_child(spikes)
	spikes.translation = Vector3(-WIDTH/2, -RADIUS, -DEPTH/2)

func spawn_heart():
	if spikes_on < 0 or not GameManager.health_is_not_max():
		return
	if Random.boolean(0.7):
		return
	$HeartContainer.rotation = Vector3(0, 0, PI/2 * (spikes_on + 2) )
	var heart = HeartScene.instance()
	$HeartContainer.add_child(heart)
	heart.translation = Vector3(0, -RADIUS, DEPTH/2)

func _on_Timer_timeout():
	queue_free()
