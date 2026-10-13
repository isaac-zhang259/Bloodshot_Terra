extends Node2D
class_name Weapon

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
@onready var charge_particles: GPUParticles2D = get_node("Node2D/Sprite2D/ChargeParticles")
@onready var hitbox: Area2D = get_node("Node2D/Sprite2D/Hitbox")

var weapon_name: String

func weapon_set_name(w_n: String) -> void:
	weapon_name = w_n

func get_input() -> void:
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
	animation_player.play(weapon_name + "_attack_animations/cancel_attack")
	
func is_busy() -> bool:
	return animation_player.is_playing() or charge_particles.emitting
