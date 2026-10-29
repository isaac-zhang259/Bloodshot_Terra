extends Room

const WEAPONS: Array = [preload("res://Weapons/war_hammer.tscn")]

@onready var weapon_pos: Marker2D = get_node("WeaponPos")
@onready var spike: Hitbox = get_node("Traps/Spikes")
@onready var health_pot: Area2D = get_node("HealthPotion")

func _spawn_weapon() -> void:
	var weapon: Node2D = WEAPONS[randi() % WEAPONS.size()].instantiate()
	weapon.position = weapon_pos.position
	weapon.on_floor = true
	add_child(weapon)
	
func activate_traps_and_heals() -> void:
	health_pot.show()
	spike.active = true
	health_pot.active = true
