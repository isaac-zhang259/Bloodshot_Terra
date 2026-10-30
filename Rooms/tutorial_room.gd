extends Room

const WEAPONS: Array = [preload("res://Weapons/war_hammer.tscn")]

@onready var weapon_pos: Marker2D = get_node("WeaponPos")
@onready var spike: Hitbox = get_node("Traps/Spikes")
@onready var health_pot: Area2D = get_node("HealthPotion")

func tutorial_spawn_enemy(spawning_enemy) -> void:
	for enemy_position in enemy_positions_container.get_children():
		num_enemies += 1
		var enemy: CharacterBody2D
		enemy = spawning_enemy.instantiate()
		
		enemy.position = enemy_position.position
		enemy.tutorial_enemy = true
		call_deferred("add_child", enemy)
		
		var spawn_explosion: AnimatedSprite2D = SPAWN_EXPLOSION_SCENE.instantiate()
		spawn_explosion.position = enemy_position.position
		call_deferred("add_child", spawn_explosion)

func _spawn_weapon() -> void:
	var weapon: Node2D = WEAPONS[randi() % WEAPONS.size()].instantiate()
	weapon.position = weapon_pos.position
	weapon.on_floor = true
	add_child(weapon)
	
func activate_traps_and_heals() -> void:
	health_pot.show()
	spike.active = true
	health_pot.active = true
