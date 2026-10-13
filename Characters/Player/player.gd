extends Character

enum{UP, DOWN}

var current_weapon: Node2D

@onready var weapons: Node2D = get_node("Weapons")

func _ready() -> void:
	current_weapon = weapons.get_child(0)

func _process(_delta: float) -> void:
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	if mouse_direction.x > 0 and animated_sprite.flip_h:
		animated_sprite.flip_h = false
	elif mouse_direction.x < 0 and not animated_sprite.flip_h:
		animated_sprite.flip_h = true
	
	current_weapon.move(mouse_direction, current_weapon.name)
	
func get_input() -> void:
	mov_direction = Vector2.ZERO
	if Input.is_action_pressed("down"):
		mov_direction += Vector2.DOWN
	if Input.is_action_pressed("up"):
		mov_direction += Vector2.UP
	if Input.is_action_pressed("left"):
		mov_direction += Vector2.LEFT
	if Input.is_action_pressed("right"):
		mov_direction += Vector2.RIGHT
	
	if not current_weapon.is_busy():
		if Input.is_action_just_released("previous_weapon"):
			_switch_weapon(UP)
		elif Input.is_action_just_released("next_weapon"):
			_switch_weapon(DOWN)
			
	current_weapon.get_input(current_weapon.name)

func _switch_weapon(direction: int) -> void:
	var index: int = current_weapon.get_index()
	if direction == UP:
		index -= 1
		if index < 0:
			index = weapons.get_child_count() - 1
	else:
		index += 1
		if index > weapons.get_child_count() - 1:
			index = 0
			
	current_weapon.hide()
	current_weapon = weapons.get_child(index)
	current_weapon.show()

func cancel_attack() -> void:
	current_weapon.cancel_attack(current_weapon.name)

func switch_camera() -> void:
	var main_scene_camera: Camera2D = get_parent().get_node("Camera2D")
	main_scene_camera.position = position
	main_scene_camera.make_current()
	#get_node("Camera2D").current = false
