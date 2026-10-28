extends Node2D
class_name Weapon

@export var on_floor: bool = false

var tween: Tween = null
@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
@onready var charge_particles: GPUParticles2D = get_node("Node2D/Sprite2D/ChargeParticles")
@onready var hitbox: Area2D = get_node("Node2D/Sprite2D/Hitbox")
@onready var player_detector: Area2D = get_node("PlayerDetector")

func _ready() -> void:
	if not on_floor:
		player_detector.set_collision_mask_value(1, false)
		player_detector.set_collision_mask_value(2, false)

var weapon_name: String
func weapon_set_name(w_n: String) -> void:
	weapon_name = w_n

func get_input() -> void:
	if Game.player.in_game:
		if Input.is_action_just_pressed("attack") and not animation_player.is_playing():
				animation_player.play(weapon_name + "_attack_animations/charge")
		elif Input.is_action_just_released("attack"):
			if animation_player.is_playing() and animation_player.current_animation == weapon_name + "_attack_animations/charge":
				animation_player.play(weapon_name + "_attack_animations/attack")
			elif charge_particles.emitting:
				animation_player.play(weapon_name + "_attack_animations/strong_attack")
			
func move(mouse_direction: Vector2) -> void:
	if not animation_player.is_playing() or animation_player.current_animation == weapon_name + "_attack_animations/charge":
		rotation = mouse_direction.angle()
		hitbox.knockback_direction = mouse_direction
		if scale.y == 1 and mouse_direction.x < 0:
			scale.y = -1
		elif scale.y == -1 and mouse_direction.x > 0:
			scale.y = 1
			
func cancel_attack() -> void:
	animation_player.play("RESET")
	
func is_busy() -> bool:
	return animation_player.is_playing() or charge_particles.emitting

func _on_player_detector_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_detector.set_collision_mask_value(1, false)
		player_detector.set_collision_mask_value(2, false)
		body.pick_up_weapon(self)
		position = Vector2.ZERO
	else:
		if tween:
			tween.kill()
		player_detector.set_collision_mask_value(2, true)
		
func interpolate_pos(initial_pos: Vector2, final_pos: Vector2) -> void:
	position = initial_pos
	tween = create_tween()
	tween.tween_property(self, "position", final_pos, 0.8).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.connect("finished", _on_Tween_tween_completed)
	player_detector.set_collision_mask_value(1, true)
	
	
func _on_Tween_tween_completed() -> void:
	player_detector.set_collision_mask_value(2, true)
