class_name PlayerInput

static func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength('right') - Input.get_action_strength('left'),
		Input.get_action_strength('up') - Input.get_action_strength('down')
	).normalized()

static func direction_just_pressed() -> Vector2:
	if Input.is_action_just_pressed("down"):
		return Vector2(0, -1)
	elif Input.is_action_just_pressed("up"):
		return Vector2(0, 1)
	elif Input.is_action_just_pressed("left"):
		return Vector2(-1, 0)
	elif Input.is_action_just_pressed("right"):
		return Vector2(1, 0)
	
	var direction = Vector2(
		Input.get_action_strength('right') - Input.get_action_strength('left'),
		Input.get_action_strength('up') - Input.get_action_strength('down')
	).normalized()
	
	if direction.y >= 0.707:
		return Vector2(0, 1)
	elif direction.y <= -0.707:
		return Vector2(0, -1)
	elif direction.x <= -0.707:
		return Vector2(-1, 0)
	elif direction.x >= 0.707:
		return Vector2(1, 0)
		
	return Vector2(0,0)


static func get_mouse_direction(node: Node) -> Vector2:
	var screen_size := Vector2(
		ProjectSettings.get_setting("display/window/size/width"), 
		ProjectSettings.get_setting("display/window/size/height")
	)
	return (node.get_viewport().get_mouse_position() - screen_size / 2).normalized()
