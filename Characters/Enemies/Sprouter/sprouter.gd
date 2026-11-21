extends Enemy

const projectile_scene = preload("res://Weapons/sprouter_projectile.tscn")

const MAX_DISTANCE_TO_PLAYER: int = 80
const MIN_DISTANCE_TO_PLAYER: int = 40
var distance_to_player: float

var aggressive: bool = false

func _on_path_timer_timeout() -> void:
	if is_instance_valid(player) and not stunned:
		distance_to_player = (player.position - global_position).length()
		if aggressive:
			_get_path_to_player()
		else:
			_get_path_to_move_away_from_player()
	else:
		path_timer.stop()
		mov_direction = Vector2.ZERO
			
func _get_path_to_move_away_from_player() -> void:
	var dir: Vector2 = (global_position - player.position).normalized()
	navigation_agent.target_position = global_position + dir * 100

func _shoot_crystals() -> void:
	for i in 4:
		var projectile: Area2D = projectile_scene.instantiate()
		get_tree().current_scene.add_child(projectile)
		projectile.launch(global_position + Vector2.UP * 30, Vector2.LEFT.rotated(deg_to_rad(i * 90)), 150)
	self.take_damage(1, Vector2.ZERO, 0)
	
func drop_crystals() -> void:
	if not SavedData.doing_tutorial and not SavedData.in_boss_fight:
		for i in range(randi_range(3, 5)):
			var opul: Area2D = opul_scene.instantiate()
			opul.position = self.global_position + Vector2.UP * 30
			opul.launch()
			get_tree().current_scene.add_child.call_deferred(opul)
		var anima: Area2D = anima_scene.instantiate()
		anima.position = self.global_position + Vector2.UP * 30
		anima.launch()
		get_tree().current_scene.add_child.call_deferred(anima)
