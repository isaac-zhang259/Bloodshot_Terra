extends CharacterBody2D
class_name Character

const HIT_EFFECT_SCENE: PackedScene = preload("res://Characters/hit_effect.tscn")
const anima_scene: PackedScene = preload("res://Currencies and Shops/anima_currency.tscn")
const opul_scene: PackedScene = preload("res://Currencies and Shops/opul_currency.tscn")

const FRICTION: float = 0.15

@export var max_hp: int = 2
@export var hp: int = 2: set = set_hp
signal hp_changed(new_hp)

@export var acceleration: int = 40
@export var max_speed: int = 100

@export var flying: bool = false
@export var knockback: bool = true
@export var stunned: bool = false

@onready var state_machine: Node = get_node("FiniteStateMachine")
@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")

var mov_direction: Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	move_and_slide()
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)
	
func move() -> void:
	mov_direction = mov_direction.normalized()
	velocity += mov_direction * acceleration
	velocity = velocity.limit_length(max_speed)

func take_damage(dam: int, dir: Vector2, force: int) -> void:
	if state_machine.state != state_machine.states.hurt and state_machine.state != state_machine.states.dead:
		_spawn_hit_effect() 
		self.hp -= dam
		if name == "Player":
			SavedData.hp = hp
			if hp <= 0:
				if self.invincible:
					self.hp = 1
					SavedData.hp = hp
					return
				if SavedData.doing_tutorial:
					SceneTransistor.start_transition_to("res://tutorial.tscn")
					SavedData.reset_data()
				else:
					SaveFile.save_currency()
					SceneTransistor.start_transition_to("res://pre_game_area.tscn")
					SavedData.reset_data()
		else:
			SavedData.hp += 1
			Game.player.hp += 1
		if hp > 0:
			state_machine.set_state(state_machine.states.hurt)
			if knockback:
				velocity += dir * force
		else:
			state_machine.set_state(state_machine.states.dead)
			if name != "Player" and not SavedData.doing_tutorial:
				drop_crystals()
			if knockback:
				velocity += dir * force * 1.5

func set_hp(new_hp: int) -> void:
	hp = clamp(new_hp, 0, max_hp)
	emit_signal("hp_changed", new_hp)

func _spawn_hit_effect() -> void:
	var hit_effect: Sprite2D = HIT_EFFECT_SCENE.instantiate()
	add_child(hit_effect)

func drop_crystals() -> void:
	for i in 5:
		var opul: Area2D = opul_scene.instantiate()
		opul.position = self.global_position
		opul.launch()
		get_tree().current_scene.add_child.call_deferred(opul)
	var anima: Area2D = anima_scene.instantiate()
	anima.position = self.global_position
	anima.launch()
	get_tree().current_scene.add_child.call_deferred(anima)
